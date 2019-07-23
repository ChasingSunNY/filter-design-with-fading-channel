clear 
EbN0dB_vector=0:3:12; %definite the EbN0 in db version
L= 1; %set the search times
Eb=1; % set the energy of signal equal to 1
for snr_i=1:length(EbN0dB_vector) %calcualte situation for different SNR
    EbN0dB=EbN0dB_vector(snr_i);  %assign new EbN0 value at the beginning of loop 
    EbN0=10.^(EbN0dB/10); %get the EbN0 real value rather in db version
    N0=Eb/EbN0; %calcualte N0
    sym_cnt=0;  %set the original total symbol count at 0 
    err_cnt=0; % set the original error symbol count at 0 
    while err_cnt<100 % we will stop the loop until 100 times error happens
        b=sign(rand-0.5); %BPSK symbol{1,-1} 
        s=sqrt(Eb/L)*b; % set the energy of signal 
        hk=sqrt(1/2)*(randn+j*randn); 
        for k=1:L 
            h(k)=hk;
            n(k)=sqrt(N0/2)*(randn+j*randn); 
            r(k)=h(k)*s+n(k); 
        end
        [T1 T2]=max(h);  %find the max fading factor in h 
        %D=sum(conj(h).*r);  %choose the maximum fading factor to calculate
        D= r()
        b_hat=sign(real(D)); % calculate D is positive or negative
        if b_hat~=b % when the polarity of received signal is different from the sent signal
            err_cnt=err_cnt+1;% make error count plus 1
        end
        sym_cnt=sym_cnt+1; % total count plus 1
    end
    BER(snr_i)=err_cnt/sym_cnt %bit error rate equal to the error count divided the total count
end
semilogy(EbN0dB_vector, BER) 
xlabel('E_b/N_0 [dB]') 
ylabel('BER')
grid
hold on 
