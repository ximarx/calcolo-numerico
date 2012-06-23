function [L,U]=fatt_lu(A)
  // fattorizzazione LU: prende in input matrice
  // quadrata e ritorna LU matrici triangolari fattori di A
  
  [m,n] = size(A) // m numero righe, n numero colonne
  // controllo che la matrice sia quadrata
  if  m~=n, error("La matrice in input deve essere quadrata")
  end
  
  // inizializzo L con le stesse dimensioni di A
  L = eye(m,n)
  
  // U sara ottenuto dalla manipolazione di A per ogni passo
  // itero per ogni colonna 
  // (eccetto l'ultima poiche nell'ultima nn ho modifiche da fare)
  for k=1:n-1 
    for i=k+1:n // itero sugli elementi subdiagonali della colonna k
      
      // calcolo il valore di m(i,k)
      // nota: in realta la formula e':
      // mik = -A(i,k)/A(k,k)
      // a questo seguirebbe un cambio di segno
      // nel momento della formazione di L
      // in quanto mi serve l'inversa
      // quindi lo cambio qui il segno, tenendo pero presente
      // che sara necessario cambiarlo
      // durante l'utilizzo del coefficiente
      // nei calcoli sotto
      mik=A(i,k)/A(k,k) 
      L(i,k)=mik
      
      // vado a modificare A:
      // non azzero ora i coefficienti subdiagonali, lo faro alla fine
      for j=k+1:m
        // modifico tutti gli elementi a destra
        // di quello azzerato per rispecchiare
        // il cambio di A
        // la formula vera e' A(i,j)=A(i,j)+mik*A(k,j)
        // ma considerando il cambio di segno apportato
        // al coefficiente mik, riporto la modifica qui
        A(i,j)=A(i,j)-mik*A(k,j)
      end
    end
  end
  
  // a questo punto devo azzerare tutti gli elementi subdiagonali di A
  U=triu(A)
endfunction