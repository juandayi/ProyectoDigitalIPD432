% Con estos script se puede comprobar el funcionamiento del resultado del
% core FFT de Xilinx, usando el ILA en su salida, los datos son guardados
% en un .CVS y luego puedo abrir estos datos con el Home/Import de Matlab y
% seleccionar los datos que deseo y copiarlos a un archivo .txt

filename = 'datafft.txt';
Fs = 1000;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = 32;             % Length of signal
t = (0:L-1)*T;        % Time vector

q = quantizer('fixed', 'nearest', 'saturate', [16 12]);% quantizer object for num2hex function  
FID = fopen(filename);
dataFromfile = textscan(FID, '%s');% %s for reading string values (hexadecimal numbers)
dataFromfile=dataFromfile{1};
dataFromfile_num = cell2mat(dataFromfile);
for i=1:1:33
 imaginary_array=hex2num(q, dataFromfile_num(i,1:4));
 real_array=hex2num(q, dataFromfile_num(i,5:8)); 
 complex_array(i)=complex(real_array,imaginary_array);
    
end
% decData = hex2num(q, dataFromfile);
% decData = cell2mat(decData);

P2 = abs(complex_array/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
figure(4);
f = Fs*(0:(L/2))/L;
plot(f,P1)
xlabel('f (Hz)')
ylabel('|P1(f)|')
fclose(FID);
