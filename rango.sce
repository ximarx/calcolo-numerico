function n=rango(A)
  // calcola il rango di una matrice generica utilizzando la scomposizione
  // LU con pivot (solo se necessario)
  // INPUT: 
  //    - A: matrice
  // OUTPUT:
  //    - n: valore del rango
  
  [L,U,P] = fatt_lu_pivot_gen(A)
  // in realta mi serve solo U per calcolare il rango
  
  // il rango e' uguale al numero righe nn nulle
  // di una matrice a scalini
  [rows,cols] = size(U)
  
  n=0
  
  for k=1:rows
    [v,p]=max(abs(U(k,1:cols)))
    if v ~= 0,
      // se la riga nn e' vuota, allora rango++
      n=n+1
    else
      // se la riga e' vuota, allora tutte le altre
      // righe sono indifferenti al fine del calcolo
      // del rango (poiche U e' a scalini)
      break;
    end
  end
  
endfunction