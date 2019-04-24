clear all;
Fs = 8000;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = 32768;             % Length of signal
t = (0:L-1)*T;        % Time vector

% Grabar audio
recObj = audiorecorder;
disp('Start speaking.')
recordblocking(recObj, 4);
disp('End of Recording.');
play(recObj);
y_audio = getaudiodata(recObj);
plot(y_audio);
xlabel('t (microseconds)');
ylabel('X(t)');
% Grabar audio

X = [y_audio; zeros(32768 - length(y_audio), 1)];
% soundsc(X,Fs);

%FFT Matlab
m = length(y_audio);      % Window length
n = pow2(nextpow2(m));  % Transform length
FFT_Result = fft(X, L);
f = (0:L-1)*(Fs/L)/10;  % Frequency range
p = FFT_Result.*conj(FFT_Result)/n;  
figure(2);
plot(f,p,'DisplayName','Core FFT FPGA');
legend('FFT Matlab');
xlabel('f (Hz)')
ylabel('|P1(f)|')
%FFT Matlab


% Datos para enviar a la FPGA
q=quantizer([16 12]); % 12 Crea el cuantizador para un formato punto fijo con tamaño de palabra de 16 bit con 12 bit de parte fraccionaria
b = num2bin(q,X);     %Convierte de numero a String binario usando el cuantizador anterior
q_inverso=quantizer([16 0]); 

aux=zeros(1,L*4); %Cantidad de muestras de la transformada L * La cantidad de byte por muestra 
                  % 4 byte (16 bit parte real y 16 bit parte imaginaria)

j=1; %las muestras originales
for i=1:4:L*4
     % Convert two's complement binary string to number using quantizer object
     % Se guardan los primeros 8 bits 
     temp=bin2num(q_inverso,b(j,1:8));
     % Convert two's complement binary string to number using quantizer object
     % Se guardan los 8 bits restantes   
     temp2=bin2num(q_inverso,b(j,9:16)); 
     
     ceros1=0;
   %  Se forma el vector con los datos reales y datos imaginarios(ceros) de
   %  las muestras de la señal para conformar los 32 bits por cada muestra necesarios para
   %  el core fft
  aux(1,i:i+3)=[temp, temp2, ceros1, ceros1];
   j=j+1;
end
sal=aux;
%  Datos para enviar a la FPGA

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tx y Rx puerto uart
s = serial('COM4','BaudRate',115200,'Parity','none','DataBits',8,'StopBits',1, 'Timeout', 15);
s.OutPutBufferSize = 186624;
s.InputBufferSize = 186624;
fopen(s);
fwrite(s,sal(1,1:65536),'uint8');
fwrite(s,sal(1,65537:L*4),'uint8');
y=fread(s,L*4);
fclose(s);
% Tx y Rx puerto uart
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Procesando los datos enviados por la FPGA

y_hex=dec2hex(y);
indice=1;
for i=1:4:length(y)
    
   y_concat(indice,1:8)= strcat(y_hex(i+3,1:2),y_hex(i+2,1:2),y_hex(i+1,1:2),y_hex(i,1:2));
    indice=indice+1;
end

for i=1:1:L
 imaginary_array=hex2num(q, y_concat(i,1:4));
 real_array=hex2num(q, y_concat(i,5:8)); 
 complex_array(i)=complex(real_array,imaginary_array);
    
end

f = (0:L-1)*(Fs/L)/10;  % Frequency range
p_fpga = complex_array.*conj(complex_array)/n; 
figure(3);
plot(f,p_fpga,'green', 'DisplayName','Core FFT FPGA');
legend('Core FFT FPGA');
xlabel('f (Hz)')
ylabel('|P1(f)|')


dato1 = transpose(complex_array);
dato = ifft(dato1);
P2_fpga = abs(dato/L);
dato2 =ifft2(dato1);
soundsc(P2_fpga);
