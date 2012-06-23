function A=item_swap(A,r,s,col)
  // eseguo lo swap dell'elemento in posizione r,col con
  // con quello in posizione s,col
  
  tmp=A(r,col)
  A(r,col)=A(s,col)
  A(s,col)=tmp
endfunction