function [x, iter] = x_bisezioni( f, a, b, prec, maxIter)
        
  fa = f(a);
  fb = f(b);
  
//  disp(string(fa))
//  disp(string(fb))
//  disp(string(maxIter))
  
  if fa*fb > 0 then
    error('Bolzano nn soddisfatto')
  end
  
  f2 = ( a + b ) / 2
  y_f2 = f(f2)
  // valuto in quale spazio proseguire
  if y_f2 * fa <= 0 then
    if (f2 - a > prec) & (maxIter > 0),
      //disp("Ricorsione 1")
      [p1, p2] = x_bisezioni(f, a, f2, prec, maxIter -1)
    else
//      disp("FINE a: ");      
  //    disp(string(f2 - a ));
  //      disp(string(maxIter));
      p1 = f2
      p2 = 0
    end
  else
    if (b - f2 > prec) & (maxIter > 0),
//      disp("Ricorsione 2")
      [p1, p2] = x_bisezioni(f, f2, b, prec, maxIter -1)
    else
//      disp("FINE b: ");
//      disp(string(b-f2));
//      disp(string(maxIter));
      p1 = f2
      p2 = 0
    end
  end
  x = p1
  iter = p2 + 1
endfunction
