clear 
EbN0dB_vector=0:2:20; %definite the EbN0 in db version

Eb=1; % set the energy of signal equal to 1
for snr_i=1:length(EbN0dB_vector) %calcualte situation for different SNR
    EbN0dB=EbN0dB_vector(snr_i);  %assign new EbN0 value at the beginning of loop 
    EbN0=10.^(EbN0dB/10); %get the EbN0 real value rather in db version
    N0=Eb/EbN0; %calcualte N0
    sym_cnt=0;  %set the original total symbol count at 0 
    err_cnt=0; % set the original error symbol count at 0 
    while err_cnt<500  %set the loop condition
        s=sqrt(Eb)*sign(rand-0.5)+j*sqrt(Eb)*sign(rand-0.5);   %set signal value
        h=sqrt(1/2)*(randn+j*randn); % set fading parameter value 
        n=sqrt(N0/2)*(randn+j*randn); % set noise value 
        r=h*s + n;  % get the equation of received value
        D=r*exp(-j*angle(h));  
        s_hat2=sign(imag(D)); %get decision variable D
        s_hat=sign(real(D)); % calculate D is positive or negative
        if s_hat ~= sign(s) % when the polarity of received signal is different from the sent signal 
            err_cnt=err_cnt+1; % make error count plus 1
        end
    if sign(imag(s))~=s_hat2
        err_cnt=err_cnt+1; 
    end
    sym_cnt=sym_cnt+2;  % total count plus 1
    end
BER(snr_i)=err_cnt/sym_cnt %bit error rate equal to the error count divided the total count
end
semilogy(EbN0dB_vector, BER) %plot bit error rate over SNR
xlabel('E_b/N_0 [dB]') % set name of xlabel
ylabel('BER') % set name of ylabel
grid