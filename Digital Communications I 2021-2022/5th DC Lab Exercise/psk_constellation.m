%Eirini Donti 03119839
function psk_constellation (k)
  % k is the number of bits per symbol
  % mapping is the vector of psk points, in the gray-coding order
  % i.e. mapping(1)<->00...00, mapping(2)<->00...01,
  % mapping(3)<->00...10, ..
  %For 16-PSK, set k=4;
  L= 2^k;
  ph1=[pi/4];
  theta=[ph1; -ph1; pi-ph1; -pi+ph1];
  mapping=exp(1j*theta);
  if(k>2)
  for j=3:k
  theta=theta/2;
  mapping=exp(1j*theta);
  mapping=[mapping; -conj(mapping)];
  theta=angle(mapping);
  end
  end 
  scatterplot(mapping);
  text(real(mapping),imag(mapping),num2str(de2bi([0:L-1].',k,'left-msb')),'FontSize',7, 'Color','white');
end