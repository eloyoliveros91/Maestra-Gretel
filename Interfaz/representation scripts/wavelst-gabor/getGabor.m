%% Get Gabor
% Calculo de los bancos de Gabor-Wavelets
function [ GW ] = getGabor( M, N, U, V )
% [GW]=GETGABOR(M,N,U,V)
%
% param M ancho de la señal
% param N alto de la señal
% param U cantidad de orientaciones 
% param V cantidad de scalas 


%% 
% Crear las bases de Gabor
Kmax = pi/2;
f = sqrt( 2 );
Delt = 2 * pi;
Delt2 = Delt * Delt;
GW={};


for v = 0 : V
    for u = 1 : U
        GW = [GW {GaborWavelet(M, N, Kmax, f, u, v, Delt2)}]; % Create the Gabor wavelets 
    end
end
%crear las bases de Gabor

end

