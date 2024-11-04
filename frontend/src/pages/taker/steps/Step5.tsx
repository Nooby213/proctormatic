import React, { useState, useEffect } from 'react';
import styles from '@/styles/Step.module.css';
import CustomButton from '@/components/CustomButton';
import TermsModal from '@/components/TermsModal';
import { useNavigate } from 'react-router-dom';
import { useTakerStore } from '@/store/TakerAuthStore';
import axiosInstance from '@/utils/axios';
import { IoIosCheckmark } from "react-icons/io";

const Step5: React.FC = () => {
  const { testId } = useTakerStore();
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    verificationCode: ''
  });
  const [isEmailSent, setIsEmailSent] = useState(false);
  const [isVerified, setIsVerified] = useState(false);
  const [timer, setTimer] = useState<number>(0);
  const [emailStatus, setEmailStatus] = useState<string>('');
  const [isNameValid, setIsNameValid] = useState<boolean>(true);
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [verificationError, setVerificationError] = useState<string>('');
  const navigate = useNavigate();

  // 한글 이름 정규식 검사
  const validateName = (name: string) => {
    const nameRegex = /^[가-힣]{2,10}$/;
    return nameRegex.test(name);
  };

  // 타이머 관리
  useEffect(() => {
    let interval: NodeJS.Timeout;
    if (timer > 0) {
      interval = setInterval(() => {
        setTimer(prevTimer => prevTimer - 1);
      }, 1000);
    } else if (timer === 0) {
      setEmailStatus('');
    }
    return () => clearInterval(interval);
  }, [timer]);

  // 입력 필드 변경 핸들러
  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { id, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [id === 'applicantName' ? 'name' : 
      id === 'emailAddress' ? 'email' : 
      id === 'emailVerification' ? 'verificationCode' : id]: value
    }));

    if (id === 'applicantName') {
      setIsNameValid(validateName(value));
    }
  };

  // 이메일 인증번호 요청 처리
  const handleEmailVerificationRequest = async () => {
    if (!formData.email) {
      console.log('이메일을 입력해주세요');
      return;
    }

    setIsLoading(true); // 로딩 상태 시작
    try {
      await axiosInstance.post('/taker/email/', {
        id: testId,
        email: formData.email
      });
      
      setIsEmailSent(true);
      setVerificationError(''); // 에러 메시지 초기화
      setTimer(300);
      setEmailStatus('인증번호가 발송되었습니다.');
    } catch (error) {
      if (error.response && error.response.status === 400) {
        setVerificationError(error.response.data.message || '잘못된 요청입니다.');
      } else {
        setVerificationError('네트워크 상태를 확인해주세요.');
      }
      console.error('인증번호 발송 실패:', error);
    } finally {
      setIsLoading(false); // 로딩 상태 종료
    }
  };

  // 인증 코드 확인 처리
  const handleVerificationCodeSubmit = async () => {
    if (!formData.verificationCode) {
      console.log('인증 코드를 입력해주세요');
      return;
    }

    setIsLoading(true); // 로딩 상태 시작
    try {
      const response = await axiosInstance.put('/taker/email/', {
        email: formData.email,
        code: formData.verificationCode
      });

      if (response.status === 200) {
        console.log('이메일 인증 성공');
        setIsVerified(true);
        setVerificationError(''); // 에러 메시지 초기화
        setEmailStatus('');
        setTimer(0);
      }
    } catch (error) {
      if (error.response && error.response.status === 400) {
        setVerificationError(error.response.data.message || '잘못된 요청입니다.');
      } else {
        console.error('이메일 인증 실패:', error);
        setVerificationError('네트워크 상태를 확인해주세요.');
      }
      setIsVerified(false);
    } finally {
      setIsLoading(false); // 로딩 상태 종료
    }
  };

  const handleConfirm = () => {
    if (!isVerified || !isNameValid) {
      console.log('모든 인증을 완료해주세요');
      return;
    }
    setIsModalOpen(false);
  };

  // 타이머 포맷팅 함수
  const formatTime = (seconds: number): string => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  return (
    <>
      <div className={styles.StepTitleBox}>
        <div className={styles.StepTitle}>응시자 정보 입력</div>
        <div className={styles.StepSubTitle}>응시자 정보를 정확하게 입력해주세요.</div>
      </div>
      <div className={`${styles.StepInner} ${styles.test1}`}>
        <div className={styles.InnerContainer}>
          <label htmlFor="applicantName">응시자 이름</label>
          <div className={styles.InnerInputAuth}>
            <input
              type="text"
              id="applicantName"
              value={formData.name}
              onChange={handleInputChange}
              style={{ borderBottomColor: isNameValid ? '' : 'red' }}
            />
            {!isNameValid && formData.name && (
              <span style={{ color: 'red', marginLeft: '10px', fontSize: '14px' }}>
                이름을 정확히 입력해주세요.
              </span>
            )}
          </div>
        </div>

        <div className={styles.InnerContainer}>
          <label htmlFor="emailAddress">이메일 주소 (본인 확인)</label>
          <div className={styles.InnerInputAuth}>
            <input
              type="email"
              id="emailAddress"
              value={formData.email}
              onChange={handleInputChange}
              disabled={isVerified}
            />
            {isVerified ? (
              <span style={{ 
                padding: '8px 16px',
                color: '#2196F3',
                fontWeight: 500,
                display: 'flex',
                justifyContent: 'center',
                alignItems: 'center',
              }}><IoIosCheckmark size={'22px'} />인증완료</span>
            ) : (
              <button 
                onClick={handleEmailVerificationRequest} 
                disabled={!formData.email || isLoading}
                className={styles.buttonTest}
              >
                {isLoading ? (
                  <div className={styles.loadingSpinner}></div>
                ) : (
                  isEmailSent ? '인증번호 재발송' : '이메일 인증'
                )}
              </button>
            )}
          </div>
          {!isVerified && emailStatus && (
            <div style={{ 
              fontSize: '14px', 
              marginTop: '5px',
              color: 'green'
            }}>
              {emailStatus}
              {timer > 0 && ` (${formatTime(timer)})`}
            </div>
          )}
        </div>

        {!isVerified && isEmailSent && (
          <div className={styles.InnerContainer}>
            <label htmlFor="emailVerification">이메일 인증</label>
            <div className={styles.InnerInputAuth}>
              <input
                type="text"
                id="emailVerification"
                value={formData.verificationCode}
                onChange={handleInputChange}
                disabled={!isEmailSent}
              />
              <button 
                onClick={handleVerificationCodeSubmit} 
                disabled={!isEmailSent || !formData.verificationCode || isLoading}
              >
                인증하기
              </button>
            </div>
            {verificationError && (
              <div style={{ 
                fontSize: '14px', 
                marginTop: '5px',
                color: 'red'
              }}>
                {verificationError}
              </div>
            )}
          </div>
        )}
      </div>
      <div className={styles.StepFooter}>
        <CustomButton 
          onClick={() => setIsModalOpen(true)}
          state={isVerified && isNameValid ? 'default' : 'disabled'}
        >
          확인했습니다
        </CustomButton>
      </div>

      <TermsModal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        onConfirm={handleConfirm}
      />
    </>
  );
};

export default Step5;
