function A=row_swap(A,r,s)
  // Effetta lo swap della riga r con la riga s
  // nella matrice A
  // TODO Aggiungere controllo su validita' indici di riga e colonna
  tmp=A(r,:)
  A(r,:)=A(s,:)
  A(s,:)=tmp
endfunction
