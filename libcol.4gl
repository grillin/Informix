database penado

globals "globals.4gl"

################################

function ventana_pais()
  define 
	 i     integer,
	 n     integer,
	 param decimal(05,0),

	 ra array[500] of record 
			  codpara smallint,
			  despara char(30)
                         end record,

         r               record
			  codpara smallint,
			  despara char(30)
                         end record

  open window  f1 at 5,10 with form "fvpais" 
	    attribute (border,form line first+1,message line first)

   message " Esc=iniciar busqueda"

   declare c1 cursor for select cod_pais, des_pais
			   from pais
                           order by cod_pais

   let i=0
   foreach c1 into r.*
       let i = i + 1
       let ra[i].codpara = r.codpara
       let ra[i].despara = r.despara
   end foreach

   message " Esc=Seleccionar Pais"

   call set_count(i)
   display array ra to rlp.* 

   let n = arr_curr()    
   let param = ra[n].codpara

  close window f1

  return param

end function

############################

function ventana_dpto(cod )
  define 
         cod   smallint,
	 i     integer,
	 n     integer,
	 param decimal(05,0),

	 ra array[500] of record 
			  codpara smallint,
			  despara char(30)
                         end record,

         r               record
			  codpara smallint,
			  despara char(30)
                         end record

  open window  f1 at 5,10 with form "fvpais" 
	    attribute (border,form line first+1,message line first)

   message " Esc=iniciar busqueda"

   declare c3 cursor for select cod_dpto, des_dpto
			   from dpto
                          where cod_pais= cod
                           order by cod_dpto

   let i=0
   foreach c3 into r.*
       let i = i + 1
       let ra[i].codpara = r.codpara
       let ra[i].despara = r.despara
   end foreach

   message " Esc=Seleccionar Dpto"

   call set_count(i)
   display array ra to rlp.* 

   let n = arr_curr()    
   let param = ra[n].codpara

  close window f1

  return param

end function

############################

function ventana_nacionalidad()
  define 
	 i     integer,
	 n     integer,
	 param decimal(05,0),

	 ra array[500] of record 
			  codpara smallint,
			  despara char(30)
                         end record,

         r               record
			  codpara smallint,
			  despara char(30)
                         end record

  open window  f1 at 5,10 with form "fvpais" 
	    attribute (border,form line first+1,message line first)

   message " Esc=iniciar busqueda"

   declare c4 cursor for select cod_nal, des_nal
			   from nacionalidad
                         order by cod_nal

   let i=0
   foreach c4 into r.*
       let i = i + 1
       let ra[i].codpara = r.codpara
       let ra[i].despara = r.despara
   end foreach

   message " Esc=Seleccionar Nacionalidad"

   call set_count(i)
   display array ra to rlp.* 

   let n = arr_curr()    
   let param = ra[n].codpara

  close window f1

  return param

end function

############################

function ventana_idioma()
  define 
	 i     integer,
	 n     integer,
	 param decimal(05,0),

	 ra array[500] of record 
			  codpara smallint,
			  despara char(30)
                         end record,

         r               record
			  codpara smallint,
			  despara char(30)
                         end record

  open window  f1 at 5,10 with form "fvpais" 
	    attribute (border,form line first+1,message line first)

   message " Esc=iniciar busqueda"

   declare c5 cursor for select cod_idioma, des_idioma
			   from idiomas
                         order by cod_idioma

   let i=0
   foreach c5 into r.*
       let i = i + 1
       let ra[i].codpara = r.codpara
       let ra[i].despara = r.despara
   end foreach

   message " Esc=Seleccionar Idioma"

   call set_count(i)
   display array ra to rlp.* 

   let n = arr_curr()    
   let param = ra[n].codpara

  close window f1

  return param

end function

############################

function ventana_religion()
  define 
	 i     integer,
	 n     integer,
	 param decimal(05,0),

	 ra array[500] of record 
			  codpara smallint,
			  despara char(30)
                         end record,

         r               record
			  codpara smallint,
			  despara char(30)
                         end record

  open window  f1 at 5,10 with form "fvpais" 
	    attribute (border,form line first+1,message line first)

   message " Esc=iniciar busqueda"

   declare c6 cursor for select cod_rel, des_rel
			   from religion
                         order by cod_rel

   let i=0
   foreach c6 into r.*
       let i = i + 1
       let ra[i].codpara = r.codpara
       let ra[i].despara = r.despara
   end foreach

   message " Esc=Seleccionar Religion"

   call set_count(i)
   display array ra to rlp.* 

   let n = arr_curr()    
   let param = ra[n].codpara

  close window f1

  return param

end function

############################

function ventana_profesion()
  define 
	 i     integer,
	 n     integer,
	 param decimal(05,0),

	 ra array[500] of record 
			  codpara smallint,
			  despara char(30)
                         end record,

         r               record
			  codpara smallint,
			  despara char(30)
                         end record

  open window  f1 at 5,10 with form "fvpais" 
	    attribute (border,form line first+1,message line first)

   message " Esc=iniciar busqueda"

   declare c7 cursor for select cod_prof, des_prof
			   from profesion
                         order by cod_prof

   let i=0
   foreach c7 into r.*
       let i = i + 1
       let ra[i].codpara = r.codpara
       let ra[i].despara = r.despara
   end foreach

   message " Esc=Seleccionar Profesion"

   call set_count(i)
   display array ra to rlp.* 

   let n = arr_curr()    
   let param = ra[n].codpara

  close window f1

  return param

end function

############################

function ventana_retiro()
  define 
	 i     integer,
	 n     integer,
	 param decimal(05,0),

	 ra array[500] of record 
			  codpara smallint,
			  despara char(30)
                         end record,

         r               record
			  codpara smallint,
			  despara char(30)
                         end record

  open window  f1 at 5,10 with form "fvpais" 
	    attribute (border,form line first+1,message line first)

   message " Esc=iniciar busqueda"

   declare c9 cursor for select cod_ret, des_ret
			   from retiros
                         order by cod_ret

   let i=0
   foreach c9 into r.*
       let i = i + 1
       let ra[i].codpara = r.codpara
       let ra[i].despara = r.despara
   end foreach

   message " Esc=Seleccionar Retiro"

   call set_count(i)
   display array ra to rlp.* 

   let n = arr_curr()    
   let param = ra[n].codpara

  close window f1

  return param

end function

############################

function ventana_colegio_origen()
  define 
	 i     integer,
	 n     integer,
	 param decimal(05,0),

	 ra array[500] of record 
			  codpara smallint,
			  despara char(30)
                         end record,

         r               record
			  codpara smallint,
			  despara char(30)
                         end record

  open window  f1 at 5,10 with form "fvpais" 
	    attribute (border,form line first+1,message line first)

   message " Esc=iniciar busqueda"

   declare c10 cursor for select cod_col, des_col
			   from col_origen
                         order by cod_col

   let i=0
   foreach c10 into r.*
       let i = i + 1
       let ra[i].codpara = r.codpara
       let ra[i].despara = r.despara
   end foreach

   message " Esc=Seleccionar Colegio"

   call set_count(i)
   display array ra to rlp.* 

   let n = arr_curr()    
   let param = ra[n].codpara

  close window f1

  return param

end function

############################

function ventana_beca()
  define 
	 i     integer,
	 n     integer,
	 param decimal(05,0),

	 ra array[500] of record 
			  codpara smallint,
			  despara char(30)
                         end record,

         r               record
			  codpara smallint,
			  despara char(30)
                         end record

  open window  f1 at 5,10 with form "fvpais" 
	    attribute (border,form line first+1,message line first)

   message " Esc=iniciar busqueda"

   declare c11 cursor for select cod_bec, des_bec
			   from tipo_beca
                         order by cod_bec

   let i=0
   foreach c11 into r.*
       let i = i + 1
       let ra[i].codpara = r.codpara
       let ra[i].despara = r.despara
   end foreach

   message " Esc=Seleccionar Beca"

   call set_count(i)
   display array ra to rlp.* 

   let n = arr_curr()    
   let param = ra[n].codpara

  close window f1

  return param

end function

############################

function ventana_estado()
  define 
	 i     integer,
	 n     integer,
	 param decimal(05,0),

	 ra array[500] of record 
			  codpara smallint,
			  despara char(30)
                         end record,

         r               record
			  codpara smallint,
			  despara char(30)
                         end record

  open window  f1 at 5,10 with form "fvpais" 
	    attribute (border,form line first+1,message line first)

   message " Esc=iniciar busqueda"

   declare c12 cursor for select cod_est, des_est
			   from estado
                         order by cod_est

   let i=0
   foreach c12 into r.*
       let i = i + 1
       let ra[i].codpara = r.codpara
       let ra[i].despara = r.despara
   end foreach

   message " Esc=Seleccionar Estado"

   call set_count(i)
   display array ra to rlp.* 

   let n = arr_curr()    
   let param = ra[n].codpara

  close window f1

  return param

end function

############################

function des_pais(cod)
   define 
	  cod    smallint,
          nombre char(30),
	  x      char(30)

  select des_pais into x
   from pais
   where cod_pais = cod

  if status = notfound then
   let x="" 
  end if

  let nombre = x clipped

 return nombre

end function

################################

function des_estado(cod)
   define 
	  cod    smallint,
          nombre char(30),
	  x      char(30)

  select des_est into x
   from estado
   where cod_est = cod

  if status = notfound then
   let x="" 
  end if

  let nombre = x clipped

 return nombre

end function

################################

function des_beca(cod)
   define 
	  cod    smallint,
          nombre char(30),
	  x      char(30)

  select des_bec into x
   from tipo_beca
   where cod_bec = cod

  if status = notfound then
   let x="" 
  end if

  let nombre = x clipped

 return nombre

end function

################################

function des_colegio_origen(cod)
  define 
	 cod    smallint,
         nombre char(30),
	 x      char(30)

  select des_col into x
    from col_origen
   where cod_col = cod

  if status = notfound then
     let x="" 
  end if

  let nombre = x clipped

  return nombre

end function

################################

function des_dpto(pais, cod)
   define 
	  pais   smallint,
	  cod    smallint,
          nombre char(30),
	  x      char(30)

  select des_dpto into x
   from dpto
   where cod_dpto = cod
     and cod_pais = pais

  if status = notfound then
   let x="" 
  end if

  let nombre = x clipped

 return nombre

end function

################################

function des_nacionalidad(cod)
   define 
	  pais   smallint,
	  cod    smallint,
          nombre char(30),
	  x      char(30)

  select des_nal into x
   from nacionalidad
   where cod_nal= cod

  if status = notfound then
   let x="" 
  end if

  let nombre = x clipped

 return nombre

end function

################################

function des_idioma(cod)
   define 
	  pais   smallint,
	  cod    smallint,
          nombre char(30),
	  x      char(30)

  select des_idioma into x
   from idiomas
   where cod_idioma = cod

  if status = notfound then
   let x="" 
  end if

  let nombre = x clipped

 return nombre

end function

################################

function des_religion(cod)
   define 
	  pais   smallint,
	  cod    smallint,
          nombre char(30),
	  x      char(30)

  select des_rel into x
   from religion
   where cod_rel = cod

  if status = notfound then
   let x="" 
  end if

  let nombre = x clipped

 return nombre

end function

################################

function nom_apoderado(codapo)
   define 
	  codapo integer,
          nombrea char(40),
	  x      char(40)

   select nombre into x
     from apodera
    where cod = codapo

  if status = notfound then
   let x="" 
  end if

  let nombrea = x clipped

 return nombrea

end function

################################

function des_profesion(cod)
   define 
	  cod     integer,
          nombrea char(30),
	  x       char(30)

   select des_prof into x
     from profesion
    where cod_prof = cod

  if status = notfound then
   let x="" 
  end if

  let nombrea = x clipped

 return nombrea

end function

################################

function des_retiro(cod)
   define 
	  cod     integer,
          nombre char(30),
	  x       char(30)

   select des_ret into x
     from retiros
    where cod_ret = cod

  if status = notfound then
   let x="" 
  end if

  let nombre = x clipped

 return nombre

end function

################################

function ventana_apoderado()
  define 
	 q1,q2 char(100),
	 i     integer,
	 n     integer,

	 ra array[500] of record 
			  cod    like apodera.cod,
			  nombre like apodera.nombre
                         end record,

         r               record
			  cod    like apodera.cod,
			  nombre like apodera.nombre
                         end record


  open window  f8 at 5,10 with form "fvapo"
       attribute (border, form line first+1, message line first)

   message " Esc=inciar busqueda "

   construct by name q1 on apodera.cod, apodera.nombre
   
   let q2="select cod, nombre from apodera where " ,q1 clipped ,
          " order by nombre"

   prepare s8 from q2
   declare c8 cursor for s8

   let i=0
   foreach c8 into r.*
       let i = i + 1
       let ra[i].cod = r.cod
       let ra[i].nombre = r.nombre

       if i = 500 then
         error "existen mas datos"
         sleep 1
         exit foreach
       end if

   end foreach

   message "         ESC= Seleccionar Apoderado"

   call set_count(i)
   display array ra to rlp.* 

   let n = arr_curr()    
   let r.cod = ra[n].cod

  close window f8

  return r.cod

end function

############################


function existe_apoderado(codi)
   define codi like apodera.cod
              
  select *
    from apodera
   where cod = codi
  
 if status = notfound then 
   return false
 else
   return true
 end if

end function

################################

function existe_pais(codi)
   define codi like pais.cod_pais
              
  select *
    from pais
   where cod_pais = codi
  
 if status = notfound then 
   return false
 else
   return true
 end if

end function

################################

function existe_dpto(codi, codpais)

   define codi like dpto.cod_dpto,
          codpais like pais.cod_pais
              
  select *
    from dpto
   where cod_dpto = codi
     and cod_pais = codpais
  
 if status = notfound then 
   return false
 else
   return true
 end if

end function

################################

function existe_nacion(codi)

   define codi like nacionalidad.cod_nal
              
  select *
    from nacionalidad
   where cod_nal = codi
  
 if status = notfound then 
   return false
 else
   return true
 end if

end function

################################

function existe_idioma(codi)

  define codi like idiomas.cod_idioma
              
  select *
    from idiomas
   where cod_idioma = codi
  
 if status = notfound then 
   return false
 else
   return true
 end if

end function

################################

function existe_religion(codi)

  define codi like religion.cod_rel
              
  select *
    from religion
   where cod_rel= codi
  
 if status = notfound then 
   return false
 else
   return true
 end if

end function

################################
