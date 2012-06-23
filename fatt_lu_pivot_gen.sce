function [L,U,P]=fatt_lu_pivot_gen(A)
  // fattorizzazione LU con tecnica del pivot parziale se necessario:
  // Input: matrice generica mxn
  // Output:
  //    L matrice triangolare inferiore speciale
  //    U matrice ridotta a scalini
  //    P matrice delle permutazioni
  
  [m,n] = size(A) // m numero righe, n numero colonne
  
  min_dim = min(m,n)
  
  L=eye(m, min_dim)
  P=eye(m, m)
  // U sara ottenuto dalla manipolazione di A per ogni passo
  // itero per ogni riga 
  // (eccetto l'ultima poiche nell'ultima nn ho modifiche da fare)
  for k=1:m-1
    
    // se il numero di colonna > riga, finisco qui
    if k > n,
      break;
    end
    
    _pivot_enabled = %f
    
    // devo identificare l'elemento da swappare
    if A(k,k) == 0,
      
      _pivot_enabled = %t
      
      // cerco il massimo elemento
      [value, max_found] = max(abs(A(k+1:m,k)))
      
      // aggiusto la k
      max_found = max_found + k
      
      
      if value == 0,
        // la riga da sostituire e' ancora 0, k++
        continue
      end
        
      // in max_found ho l'indice della riga con 
      // elemento massimo (in valore assoluto)
      // procedo allo swap
      A=row_swap(A,k,max_found)
      
      // a questo punto devo memorizzare lo swap in P
      P=row_swap(P,k,max_found)
            
    end
    
   
    for i=k+1:m // itero sugli elementi subdiagonali della colonna k
      
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
      for j=k+1:n
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
    if _pivot_enabled == %t,
      for l=1:k-1
        L=item_swap(L,k,max_found,l)
      end
    end
          
  end
  
  // a questo punto devo azzerare tutti gli elementi subdiagonali di A
  U=triu(A)  
  
  
  // a questo punto devo garantire che l'uscita sia una matrice
  // a scalini. Ci sono casi in cui
  // (se i valori nn nulli sono oltre la diagonale)
  // nn viene eseguito correttamente lo swap
  for k=m:-1:1
    // controllo se la riga e' nulla
    [v,p]=max(abs(U(k,1:n)))
    if v ~= 0, // riga nn vuota 
      for k2=1:k-1
        [v2,p2] = max(abs(U(k2,1:n)))
        if v2 == 0,
          // posso fare lo swap
          U=row_swap(U,k,k2)
          // lo swap e' sbagliato
	  // dovrei swappare in maniera differente
	  // !!!!!!!!!!!!!!!!!!!!!!!
	  // la direzione dello swap va da t1->t2
	  // in realta dovrebbe essere t1->tn->tn+1->t2->tn-1->t1
	  // x00FE->x00AE->x0BEA->x0254
	  P=row_swap(P,k,k2)

	  // nella colonna 4 devo considerare la presenza di moltiplicatori di gauss di ordine inverso
	  // aggiungo quindi un coefficiente negativo durante il calcolo successivo:
	  // TEOREMA: coefficienti gaussiani inversi <=> inverso dei coefficienti gaussiani

          for l=1:k2-1
            L=item_swap(L,k,k2,l)
          end
        end
      end
    end
  end
  
  // Aggiungo un rapido controllo di correttezza
//  if L*U ~= P*A,
//    disp("Attenzione: LU != PA")
//  end
  
  
endfunction

