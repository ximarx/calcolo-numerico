function [L,U,P]=fatt_lu_pivot(A)
  // fattorizzazione LU con tecnica del pivot parziale:
  // Input: matrice quadrata nxn
  // Output:
  //    L matrice triangolare inferiore speciale
  //    U matrice triangolare superiore
  //    P matrice delle permutazioni
  
  [m,n] = size(A) // m numero righe, n numero colonne
  // controllo che la matrice sia quadrata
  if  m~=n, error("La matrice in input deve essere quadrata")
  end
  
  // inizializzo L con le stesse dimensioni di A
  L = eye(m,n)
  // inizializzo identica con le stesse dimesioni di A
  P = eye(m,n)
  
  // U sara ottenuto dalla manipolazione di A per ogni passo
  // itero per ogni riga 
  // (eccetto l'ultima poiche nell'ultima nn ho modifiche da fare)
  for k=1:n-1 
    
    // devo identificare l'elemento da swappare
    actual = A(k,k)
    max_found = k
    for i=k+1:n
      if abs(actual) < abs(A(i,k)),
        max_found = i
        actual=abs(A(i,k))
      end
    end
    
    // in max_found ho l'indice della riga con 
    // elemento massimo (in valore assoluto)
    // procedo allo swap
    A=row_swap(A,k,max_found)
    
    // a questo punto devo memorizzare lo swap in P
    P=row_swap(P,k,max_found)
    
   
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
    
    // al passo k devo provvedere ad applicare a tutti
    // i moltiplicatori di gauss precedenti la permutazione
    // che serve per il passo k (il moltiplicatore in colonna
    // k nn viene alterato
    for l=1:k-1
      L=item_swap(L,k,max_found,l)
    end
        
  end
  
  // a questo punto devo azzerare tutti gli elementi subdiagonali di A
  U=triu(A)
endfunction