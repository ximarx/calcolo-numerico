// calcola il prodotto righe-colonne di una matrice
// di stringhe. L'operatore c_m_c verra sostituito
// dalla concatenazione, mentre la somma da 'a+b'
function x=charmatrix_product(a,b,varargin)
  if length(varargin) > 0
    show = varargin(1);
  else
    show = %f;
  end
  // controllo che le matrici siano
  // valide (mxn * n&s)
  a_rows = size(a, "r");
  a_cols = size(a, "c");
  b_rows = size(b, "r");
  b_cols = size(b, "c");
  if ( show == %t ) then
    disp('Matrice A: ' + string(a_rows) + 'x' + string(a_cols));
    disp('Matrice B: ' + string(b_rows) + 'x' + string(b_cols));
  end
  if a_cols ~= b_rows then
    error('Errore: matrici non moltiplicabili');
  else
    x = [];
    for i = 1 : a_rows do // iterazione cij
      for j = 1 : b_cols do // iterazione cij
        t = ''; // sono costretto ad utilizzare un buffer, o dovrei avvalorare x con ''
        for k = 1 : a_cols do // sommatoria
          if t == '' then
            t = a(i,k) + b(k,j);
          else
            t = t + '+' + a(i,k) + b(k,j);
          end
        end
        x(i,j)=t;
      end
    end
  end  
  
endfunction
