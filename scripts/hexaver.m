% E.g. hexaver('2a2f38', '333846')
function hexaver(hexValue1, hexValue2)
   red1 = hexValue1(1:2);
   green1 = hexValue1(3:4);
   blue1 = hexValue1(5:6);
   red2 = hexValue2(1:2);
   green2 = hexValue2(3:4);
   blue2 = hexValue2(5:6);
   redDec = (hex2dec(red1) + hex2dec(red2))/2;
   greenDec = (hex2dec(green1) + hex2dec(green2))/2;
   blueDec = (hex2dec(blue1) + hex2dec(blue2))/2;
   disp('up')
   red = dec2hex(ceil(redDec))
   green = dec2hex(ceil(greenDec))
   blue = dec2hex(ceil(blueDec))
   disp('')
   disp('down')
   red = dec2hex(floor(redDec))
   green = dec2hex(floor(greenDec))
   blue = dec2hex(floor(blueDec))
end
