%% Gabor Wavelets
% Calculo de bancos de la tranformada Gabor-Wavelets
function GW = GaborWavelet (M, N, Kmax, f, u, v, Delt2)
% GW=GABOMWAVELET(M,N,KMAX,F,U,V,DELT2)
%
% param M ancho de la señal
% param N alto de la señal
% param Kmax frecuencia máxima
% param f es el factor de espacio entre los kernels en el dominio de frecuencia
% param u orientaciones
% param v escalas
% param Delt2
% return GW banco de gabor con escala v y orientacion u
%

%%
% Calculo del Wave Vector
k = ( Kmax/( f^v ) ) * exp( 1i*u*pi/8 );
kn2 = (abs(k))^2;
GW = zeros(M,N);

for m = -M/2 + 1 : M/2
    for n = -N/2 + 1 : N/2

        %%
        % Los filtros de Gabor pueden definirse de la siguiente forma:
        %
        % $$\psi_{\mu,\nu}(z)=\frac{\Vert k_{\mu,\nu} \Vert^2}{\sigma^2}e^{-\frac{\Vert k_{\mu,\nu} \Vert^2 \Vert z \Vert^2}{2\sigma^2}}\left[ e^{ik_{\mu,\nu}z} - e^{-\frac{\sigma^2}{2}}\right] $$
        % 
        
        GW(m+M/2,n+N/2) = ( kn2/Delt2 ) * exp( -0.5 * kn2 * ( m^2 + n^2 )/Delt2) * ( exp( 1i * ( real( k ) * m + imag ( k ) * n ) ) - exp ( -0.5 * Delt2 ) );

    end
end
