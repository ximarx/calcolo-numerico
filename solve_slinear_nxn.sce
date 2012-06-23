function x=solve_slinear_nxn(A, b)
  // Risolve un sistema lineare di tipo Ax=b utilizzando la
  // fattorizzazione LU con tecnica del massimo pivot parziale
  // INPUT:
  //    - A: matrice dei coefficienti
  //    - b: matrice dei termini noti
  // OUTPUT:
  //    - x: matrice delle incognite
  
  // come prima fase identifico L U e P di A
  // affinche PA=LU
  
  [L,U,P]=fatt_lu_pivot(A)
  
  // Moltiplico a dx Ax=b per P => PAx=Pb
  // PA = LU, quindi <=> LUx=Pb
  // Pb facilmente calcolabile come P*b
  // Riduco al sistema:
  // Ly=Pb
  // y=Ux
  
  // Sapendo che L è triangolare inferiore speciale, e' facile
  // individuare i risultati come y=L'Pb (L' inversa di L)
  
  //y=inv(L)*(P*b) //riportata gia nell'equazione successiva
  
  // una volta individuato y, riporto in y=Ux => U'y=x
  x=inv(U)*(inv(L)*(P*b))
  
endfunction