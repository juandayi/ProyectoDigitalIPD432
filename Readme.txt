 
Este repositorio contiene el proyecto de final del Ramo IPD-432 Diseño Avanzado de Sistemas Digitales.
El proyecto tiene el objetivo de hacer una caracterización del Core FFT de Xilinx, en términos de funcionamiento,
latencia y uso de recursos en la FPGA Nexys 4 DDR.
El diseño es descrito en más detalle en el pdf: ProyectoFinal

Core FFT 1024 sin ILA: Diseño con el core FFT configurado para 1024 muestras, donde es muestreada una señal y enviada sus muestras al core
a través del puerto uart con el uso de Matlab y luego el resultado devuelto por el core es enviado de vuelta a la PC por el puerto uart y
 comparado con la fft calculada por Matlab.

Core FFT 2048 con ILA: Diseño con el core FFT configurado para 2048 muestras, donde es muestreada una señal y enviada sus muestras al core
a través del puerto uart con el uso de Matlab y luego el resultado devuelto por el core es enviado de vuelta a la PC por el puerto uart y
comparado con la fft calculada por Matlab. Además es configurado el Analizador Lógico Integrado que permite detectar las señales de entrada 
de salida y de entrada al core FFT.
 
Core FFT 32768 Demo: Diseño con el core FFT configurado para 32768 muestras. Con el uso de los script de Matlab permite grabar la voz durante
 4 segundos, enviar las muestras al core fft y luego calcular la transformada inversa a las muestras devueltas por el core usando la
función de transformada inversa de matlab y es posible oir lo que se grabó previamente.