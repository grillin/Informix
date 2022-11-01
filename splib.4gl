
database penado

globals "globals.4gl" 

################

function f()
 open window we at 10,10 with 1 rows, 60 columns  attribute(border)
  display " Ha ocurrido un error ( ver archivo de errores) " at 1,1
  sleep 3
 close window we
  clear screen
  exit program
end function

#####################

function diasno(ayer,hoy)
  define ayer,hoy date,
   dias integer

 select count(*) into dias
   from noatendido
  where fecha >ayer and fecha <hoy

 if dias is null then
   let dias =0 
 end if

 return dias 

end function

####################

function mesa()
 open window w1000 at 5,5 with 1 rows ,70 columns attribute (border)
  display " No se encontraron mas datos " at 1,1
  sleep 3
 close window w1000
end function

##########################

function nomlector(cod)
   define nombre char(30),
	  cod    like lectores.codlec,
	  x  char(30)

  select nomlec into x
   from lectores
   where codlec = cod

  if status = notfound then
   let x="" 
  end if

  let nombre = x clipped

 return nombre

end function

################################

function existelector(cod)
   define cod like lectores.codlec
              
  select *
    from lectores
   where codlec = cod
  
 if status = notfound then 
   return false
 else
   return true
 end if

end function

################################

function lector_vigente(cod)
   define cod like lectores.codlec
              
  select *
    from lectores
   where codlec = cod
     and estalec = "98001"
  
 if status = notfound then 
   return false
 else
   return true
 end if

end function

################################

function nomlibro(cod)
   define nombre char(30),
	  cod    like libros.codlibro

  select nomlibro  into nombre
   from libros
   where codlibro = cod

  if status = notfound then
   let nombre = "" 
  end if

 return nombre

end function

################################

function nomlinea(x,y,z)
   define nombre char(30),
	  x like nomelibro.linea,
	  y like nomelibro.grupo,
	  z like nomelibro.subgr

  select descr into nombre
   from nomelibro
   where linea = x
     and grupo = y
     and subgr = z

  if status = notfound then
   let nombre = "" 
  end if

 return nombre

end function

################################

function existelinea(x,y,z)
   define x like nomelibro.linea,
	  y like nomelibro.grupo,
	  z like nomelibro.subgr

  select *
   from nomelibro
   where linea = x
     and grupo = y
     and subgr = z

  if status = notfound then
     return false 
  else  
     return true 
  end if

end function

################################

function nomparametro(cod)
   define nombre char(30),
	  cod    like syspenal.valorsp,
          g      decimal(02,0),
          s      decimal(03,0)

 let g = cod / 1000
 let s = cod  mod 1000

  select descrsp  into nombre
   from syspenal
   where gruposp = g
     and subgrsp = s

  if status = notfound then
   let nombre = "" 
  end if

 return nombre

end function

################################

function valorparametro(cod)
   define valor  like syspenal.valorsp,
	  cod    like syspenal.valorsp,
          g      decimal(02,0),
          s      decimal(03,0)

 let g = cod / 1000
 let s = cod  mod 1000

  select valorsp into valor
   from syspenal
   where gruposp = g
     and subgrsp = s

  if status = notfound then
   let valor = 0
  end if

 return valor

end function

################################

function existelibro(cod)
  define cod like libros.codlibro
  
  select *
    from libros
   where codlibro = cod

 if status = notfound then
    return false 
 else 
    return true
 end if

end function

################################

function existelibro_fabrica(cod)
  define cod like libros.cfablibro
  
  select *
    from libros
   where cfablibro = cod

 if status = notfound then
    return false 
 else 
    return true
 end if

end function

################################


function existecant(cod)
define cod  like libros.codlibro,
       cant decimal(10,0)

 select tomoslibro - cantpres into cant
   from libros
  where codlibro = cod

if cant is null then
  let cant = 0
end if

 return cant 

end function

################################

function existecantVE(cod)
define cod  like libros.codlibro,
       cant decimal(10,0)

 select tomoslibro into cant
   from libros
  where codlibro = cod

if cant is null then
  let cant = 0
end if

 return cant 

end function

################################

function leerprecio(cod)
  define precio like libros.preciolib,
         cod    like libros.codlibro

  select preciolib  into precio
   from libros
   where codlibro = cod

  if status = notfound then
   let precio = 0
  end if

 return precio

end function

################################

function leercosto(cod)
  define costo like libros.costolib,
         cod    like libros.codlibro

  select costolib into costo
   from libros
   where codlibro = cod

  if status = notfound or costo is null then
   let costo = 0
  end if

 return costo

end function

#######################

function nomauxiliar(cod)
    define cod like auxiliares.codaux,
	   nombre   char(30),
	   x        char(30)

         select nomaux into x
           from auxiliares
           where codaux=cod

          if status=notfound then
	    let x = ""
          end if  
          let nombre = x clipped

      return nombre

end function

###############################

function existeaux(cod)
  define cod like auxiliares.codaux

  select *
    from auxiliares
   where codaux = cod

  if status = notfound then
     return false
  else
     return true
  end if
end function

###############################
function existe_syspenal(grupo,subgrupo)
  define grupo    like syspenal.gruposp,
         subgrupo like syspenal.subgrsp

  select *
    from syspenal
   where gruposp = grupo
     and subgrsp = subgrupo

  if status = notfound then
     return false
  else
     return true
  end if

end function

###############################

function contador(x)
 define  x decimal(05,0),
	 g decimal(02,0),
	 s decimal(03,0),
	 n like syspenal.valorsp

 let g = x / 1000
 let s = x mod 1000

 whenever error continue
  

 declare csp cursor for 
  select valorsp 
    from syspenal
   where gruposp = g and
         subgrsp = s 
  for update

 foreach csp into n

   if status = 0 then

       let n = n + 1

       update syspenal
	  set valorsp = n
	  where current of csp

     else 

       let estado = status 

   end if

   return n

 end foreach
 
end function

############################

function obtener_contador(x)
 define  x decimal(05,0),
	 g decimal(02,0),
	 s decimal(03,0),
	 n like syspenal.valorsp

 let g = x / 1000
 let s = x mod 1000


  select valorsp into n
    from syspenal
   where gruposp = g 
     and subgrsp = s 

   return n
 
end function

############################

function actualizar_contador(x, ncor)
 define  x decimal(05,0),
	 ncor like syspenal.valorsp,
	 g decimal(02,0),
	 s decimal(03,0),
	 n like syspenal.valorsp

 let g = x / 1000
 let s = x mod 1000

 #whenever error continue
  
 declare consp cursor for 
  select valorsp 
    from syspenal
   where gruposp = g and
         subgrsp = s 
  for update

 foreach consp into n

   if status = 0 then

       update syspenal
	  set valorsp = ncor
	  where current of consp

     else 

       let estado = status 

   end if

 end foreach
 
end function

############################

function clear_menu()


  display "" at 1,1
  display "" at 2,1

  display "  " at 1,1
  display " Control : i = interrumpir, g = grabar, w= ventana" at 2,1

end function 

############################

function ventanalector()
  define 
	 q1,q2 char(100),
	 i     integer,
	 n     integer,

	 ra array[500] of record 
			  codlec like lectores.codlec,
			  nomlec like lectores.nomlec
                         end record,

         r               record
			  codlec like lectores.codlec,
			  nomlec like lectores.nomlec
                         end record


  open window  f1 at 5,10 with form "fvlec"
       attribute (border, form line first+1, message line first)

   message " Esc=inciar busqueda "

   construct by name q1 on lectores.codlec, lectores.nomlec
   
   let q2="select codlec, nomlec from lectores where " ,q1 clipped ,
          " order by codlec"

   prepare s1 from q2
   declare c cursor for s1

   let i=0
   foreach c into r.*
       let i = i + 1
       let ra[i].codlec = r.codlec
       let ra[i].nomlec = r.nomlec

       if i = 500 then
         error "existen mas datos"
         sleep 1
         exit foreach
       end if

   end foreach

   message "         ESC= Seleccionar Lector"

   call set_count(i)
   display array ra to rle.* 

   let n = arr_curr()    
   let r.codlec = ra[n].codlec

  close window f1

  return r.codlec

end function

############################

function ventanaauxiliar()
  define 
	 q1,q2 char(200),
	 i     integer,
	 n     integer,

	 ra array[500] of record 
			  codaux like auxiliares.codaux,
			  nomaux like auxiliares.nomaux
                         end record,

         r               record
			  codaux like auxiliares.codaux,
			  nomaux like auxiliares.nomaux
                         end record


  open window  f1 at 5,10 with form "fvaux" 
	    attribute (border,form line first+1,message line first)

   message " Esc=iniciar busqueda"
   construct by name q1 on auxiliares.codaux, auxiliares.nomaux

   let q2="select codaux, nomaux from auxiliares where " ,q1 clipped ,
          " order by codaux"

   prepare s2 from q2
   declare c1 cursor for s2

   let i=0
   foreach c1 into r.*
       let i = i + 1
       let ra[i].codaux = r.codaux
       let ra[i].nomaux = r.nomaux
   end foreach

   message "         ESC= Seleccionar Auxiliar"
   call set_count(i)
   display array ra to rla.* 

   let n = arr_curr()    
   let r.codaux = ra[n].codaux

  close window f1

  return r.codaux

end function

############################

function ventanalibro()
  define 
	 q1,q2 char(300),
	 i     integer,
	 n     integer,

	 ra array[500] of record 
			  codlibro like libros.codlibro,
			  nomlibro like libros.nomlibro,
			  tomoslibro like libros.tomoslibro,
			  cantpres   like libros.cantpres
                         end record,

         r               record
			  codlibro like libros.codlibro,
			  nomlibro like libros.nomlibro,
			  tomoslibro like libros.tomoslibro,
			  cantpres   like libros.cantpres
                         end record


  open window  f1 at 5,10 with form "fvlib" 

   attribute (border,form line first+1,message line first)
   message " Esc=iniciar busqueda"

   construct by name q1 on libros.codlibro, libros.nomlibro

  let q2="select codlibro, nomlibro, tomoslibro, cantpres from libros where " ,
	  q1 clipped , " order by codlibro"

   prepare s3 from q2
   declare c2 cursor for s3

   let i=0
   foreach c2 into r.*
       let i = i + 1
       let ra[i].codlibro = r.codlibro
       let ra[i].nomlibro = r.nomlibro
       let ra[i].tomoslibro = r.tomoslibro
       let ra[i].cantpres   = r.cantpres
       if i = 500 then
         error "existen mas datos"
         sleep 1
         exit foreach
       end if
   end foreach

   message " Esc=Seleccionar Producto "
   call set_count(i)
   display array ra to rli.* 

   let n = arr_curr()    
   let r.codlibro = ra[n].codlibro

  close window f1

  return r.codlibro

end function

############################

function ventana_linea()
  define 
	 q1,q2 char(300),
	 i     integer,
	 n     integer,

	 ra array[500] of record 
			    linea like nomelibro.linea,
			    descr like nomelibro.descr
                         end record,

	 r               record 
			    linea like nomelibro.linea,
			    descr like nomelibro.descr
                         end record


  open window  f1 at 5,10 with form "fvlin" 

   attribute (border,form line first+1,message line first)
   message " Esc=iniciar busqueda"

   construct by name q1 on nomelibro.linea, nomelibro.descr

   let q2="select linea, descr from nomelibro ",
          " where grupo = 0 ",
 	  "   and subgr = 0 " ,
	  "   and ",q1 clipped,
          " order by linea" 

   prepare s5 from q2
   declare c5 cursor for s5

   let i=0
   foreach c5 into r.*
       let i = i + 1
       let ra[i].linea = r.linea 
       let ra[i].descr  = r.descr

       if i = 500 then
         error "existen mas datos"
         sleep 1
         exit foreach
       end if

   end foreach

   message " Esc=Seleccionar Linea"
   call set_count(i)
   display array ra to rli.* 

   let n = arr_curr()    
   let r.linea = ra[n].linea

  close window f1

  return r.linea

end function

############################

function ventana_grupo(linea)
  define 
	 q1,q2 char(300),
	 i     integer,
	 n     integer,
	 linea like nomelibro.linea,

	 ra array[500] of record 
			    grupo like nomelibro.grupo,
			    descr like nomelibro.descr
                         end record,

	 r               record 
			    grupo like nomelibro.grupo,
			    descr like nomelibro.descr
                         end record


  open window  f1 at 5,10 with form "fvgru" 

   attribute (border,form line first+1,message line first)
   message " Esc=iniciar busqueda"

   construct by name q1 on nomelibro.grupo, nomelibro.descr

   let q2="select grupo, descr from nomelibro ",
          " where linea = ", linea ,
	  "   and grupo > 0 " ,
 	  "   and subgr = 0 " ,
	  "   and ",q1 clipped ,
          " order by grupo "

   prepare s6 from q2
   declare c6 cursor for s6

   let i=0
   foreach c6 into r.*
       let i = i + 1
       let ra[i].grupo  = r.grupo
       let ra[i].descr  = r.descr

       if i = 500 then
         error "existen mas datos"
         sleep 1
         exit foreach
       end if

   end foreach

   message "Esc= Seleccionar grupo"
   call set_count(i)
   display array ra to rli.* 

   let n = arr_curr()    
   let r.grupo = ra[n].grupo

  close window f1

  return r.grupo 

end function

############################

function ventana_subgr(linea,grupo)
  define 
	 q1,q2 char(300),
	 i     integer,
	 n     integer,
	 linea like nomelibro.linea,
	 grupo like nomelibro.grupo,

	 ra array[500] of record 
			    subgr like nomelibro.subgr,
			    descr like nomelibro.descr
                         end record,

	 r               record 
			    subgr like nomelibro.subgr,
			    descr like nomelibro.descr
                         end record


  open window  f1 at 5,10 with form "fvsub" 

   attribute (border,form line first+1,message line first)
   message " Esc=iniciar busqueda"

   construct by name q1 on nomelibro.subgr, nomelibro.descr

   let q2="select subgr, descr from nomelibro ",
          " where linea = ", linea ,
	  "   and grupo = ", grupo ,
 	  "   and subgr > 0 " ,
	  "   and ",q1 clipped ,
          " order by subgr "

   prepare s7 from q2
   declare c7 cursor for s7

   let i=0
   foreach c7 into r.*
       let i = i + 1
       let ra[i].subgr  = r.subgr
       let ra[i].descr  = r.descr

       if i = 500 then
         error "existen mas datos"
         sleep 1
         exit foreach
       end if

   end foreach

   message " Esc=Seleccionar Subrgrupo"
   call set_count(i)
   display array ra to rli.* 

   let n = arr_curr()    
   let r.subgr = ra[n].subgr

  close window f1

  return r.subgr

end function

############################
function ventana_relacionados(codigo)
  define 
	 q1,q2 char(300),
	 i     integer,
	 n     integer,
	 codigo like libros.codunico,

	 ra array[500] of record 
			    codlibro   like libros.codlibro,
			    nomlibro like libros.nomlibro
                         end record,

	 r               record 
			    codlibro   like libros.codlibro,
			    nomlibro like libros.nomlibro
                         end record


  open window  f1 at 5,10 with form "fvrel" 

   attribute (border,form line first+1,message line first)
   message " Codigo        Titulo "


   let q2="select codlibro, nomlibro from libros ",
          " where codunico = ", codigo,
          " order by codlibro "

   prepare s8 from q2
   declare c8 cursor for s8

   let i=0
   foreach c8 into r.*
       let i = i + 1
       let ra[i].codlibro   = r.codlibro
       let ra[i].nomlibro = r.nomlibro

       if i = 500 then
         error "existen mas datos"
         sleep 1
         exit foreach
       end if

   end foreach

   call set_count(i)
   display array ra to rli.* 


  close window f1

end function

############################

function ventanaparametro(ini,fin)
  define 
	 q1,q2 char(300),
	 i     integer,
	 n     integer,
         ini,fin decimal(02,0),
	 param decimal(05,0),

	 ra array[500] of record 
			  codpara decimal(05,0),
			  descrsp like syspenal.descrsp
                         end record,

         r               record
			  gruposp like syspenal.gruposp,
			  subgrsp like syspenal.subgrsp,
			  descrsp like syspenal.descrsp
                         end record

  open window  f1 at 5,10 with form "fvsp" 
	    attribute (border,form line first+1,message line first)

   message " Esc=iniciar busqueda"

   declare c3 cursor for select gruposp, subgrsp, descrsp
			   from syspenal
			   where gruposp between ini and fin
                             and subgrsp > 0
                           order by gruposp, subgrsp

   let i=0
   foreach c3 into r.*
       let i = i + 1
       let ra[i].codpara = r.gruposp*1000 + r.subgrsp
       let ra[i].descrsp= r.descrsp
   end foreach

   message " Esc=Seleccionar Parametro"

   call set_count(i)
   display array ra to rlp.* 

   let n = arr_curr()    
   let param = ra[n].codpara

  close window f1

  return param

end function

############################

function ventana_codigo_barra()

  define 
         r    record
		cfablibro like libros.cfablibro,
                codlibro  like libros.codlibro
              end record

  open window  f1 at 13,10 with 2 rows , 22 columns
	    attribute (border,form line 1)

   open form fvbar from "fvbar" 
   display form fvbar

   input by name r.cfablibro

  close form fvbar
  close window f1

  select codlibro into r.codlibro
    from libros
   where cfablibro = r.cfablibro

  if status = notfound then
     let r.codlibro = ""
  end if

  return r.codlibro

end function

############################

function ImprimirReporte(x)
 define x char(20),
        c char(20),
        cmd char(40)

   options prompt line 24

   prompt "Digite orden de impresion : " for c

   if c is not null then
     let cmd = c clipped," ",x clipped
     run cmd
   end if

end function

############################

function ventanaDeuda(x)
 define deuda decimal(10,2) ,
        x  like lectores.codlec

 select saldo into deuda
  from lectores 
  where codlec = x

 if deuda is null then
    let deuda= 0
 end if

 if deuda > 0  then

  error "cliente con deuda" 
  sleep 1

  open window wsal at 10,10 with form "fsal" 
                         attribute (border,form line first+1)
    input by name deuda without defaults   
      on key (control-i)
           exit input
    end input 

  close window wsal

 end if

end function 

################################

function ventanaNodevueltos(codigo)

 define codigo like lectores.codlec,
        mensaje char(30)


 if libros_nodevueltos(codigo)  then

  let mensaje = "Lector con libros no devueltos" 

  open window wsal at 10,10 with form "fnodev" 
                         attribute (border,form line first+1)
    input by name mensaje without defaults   
      on key (control-i)
           exit input
    end input 

  close window wsal

 end if

end function 


############################

function ventanaLibrosNoDevueltos(codigo)
  define 
         codigo like lectores.codlec,
	 q1,q2 char(300),
	 i     integer,
	 n     integer,
	 param decimal(05,0),

	 ra array[500] of record 
			  codlibro like libros.codlibro,
			  nomlibro like libros.nomlibro,
			  fechapres date,
                          diaspres  integer
                         end record,

         r               record
			  codlibro like libros.codlibro,
			  nomlibro like libros.nomlibro,
			  fechapres date,
                          diaspres  integer
                         end record

  open window  f1 at 5,10 with form "fvnde" 
	    attribute (border,form line first+1,message line first)

   message " Esc=iniciar busqueda"

   declare c9 cursor for select b.codlibro, nomlibro, a.fechapres, 
                                today-a.fechapres
			   from prestahea a, prestamos b, libros
			   where a.codlec = codigo
                             and a.nropresta = b.nropresta
                             and b.codlibro = libros.codlibro
                             and b.cantpres - b.cantdevu > 0
                           order by fechapres 

   let i=0
   foreach c9 into r.*
       let i = i + 1
       let ra[i].codlibro = r.codlibro
       let ra[i].nomlibro = r.nomlibro
       let ra[i].fechapres = r.fechapres
       let ra[i].diaspres= r.diaspres
   end foreach

   message " Esc=Salir "

   call set_count(i)
   display array ra to rli.* 

  close window f1


end function

###################################

function libros_nodevueltos(codigo)
   define codigo like lectores.codlec

    select unique a.codlec
      from  prestahea a, prestamos b
    where a.codlec = codigo
      and a.nropresta = b.nropresta
      and b.cantpres - b.cantdevu > 0

   if status = notfound then
       return false
   else
       return true
   end if
      
end function

function lectormaximo()
 define maximo integer 

  select max(codlec)  into maximo
    from lectores
  if maximo is null then
    let maximo = 0
  end if

   return maximo

end function

############################

function dependemaximo()
 define maximo integer 

  select max(coddep)  into maximo
    from depende
  if maximo is null then
    let maximo = 0
  end if

   return maximo

end function

############################


function ventana_castigo(monto)
   define 
	monto decimal(10,2)

  error "cliente fue castigado" 
  sleep 1

  open window wcas at 10,10 with form "fcas" 
                         attribute (border,form line first+1)
    input by name monto without defaults   
      on key (control-i)
           exit input
    end input 

  close window wcas 

end function

############################

function salir_menu()

     display "" at 1,1
     display " Control : i = interrumpir, g = grabar, w=ventana " at 2,1

end function

#############################

function ventana_nodevu(x)
   define 
	  x      like libros.codlibro,
	  cod    like lectores.codlec,
	  fpre   date, 
          nombre char(40) 

  declare c_nd cursor for 
  select codlec, fechapres 
    from prestamos
   where codlibro = x
     and cantdevu <> cantpres

  foreach c_nd into cod, fpre
  end foreach

  let nombre = nomlector(cod)

  open window wcnd at 10,10 with form "fcnd" 
                         attribute (border,form line first+1)
    input by name cod, nombre, fpre without defaults  
        attribute(yellow, reverse) 
      on key (control-i)
           exit input
    end input 

  close window wcnd

end function

############################

function nomprograma(prg)
  define prg like prgmodulos.prgnom,
         nom like prgmodulos.nombre 

  select nombre into nom
    from prgmodulos
   where prgnom = prg

 if nom is null then
   let nom=""
 end if

 return nom
end function

############################

function acceso_programa(nom)
  define nom char(20),
	 usr char(10)

  let usr = fgl_getenv("LOGNAME")

  select *
    from accmodulos
   where prgnom = nom
     and usracc = usr

  if status = notfound then
     return false
  else 
     return true 
  end if

end function

############################

function cminutos(mayer,mhoy,hayer,hhoy)
  define mayer,mhoy   date,
         hayer,hhoy datetime hour to minute,
         horas,hdia datetime hour to minute,
	 aux        interval hour to minute ,
	 hh datetime hour to hour,
	 mm datetime minute to minute,

	 dias,minutos,p,q        integer,
	 s char(2)

  let dias=mhoy-mayer
  let aux=hhoy-hayer

  if aux < interval(00:00) hour to minute
  then
    let hdia=datetime(23:59) hour to minute
    let aux =hdia-hayer
    let horas=aux+hhoy
    if dias >0 then
     let dias=dias-1
    end if
  else
    let aux=hhoy-hayer
    let horas=aux+datetime(00:00) hour to minute
  end if

   let mm=extend(horas,minute to minute )
   let s=mm
   call aentero(s) returning p

   let hh= extend(horas,hour to hour)
   let s=hh
   call aentero(s) returning q

    let minutos=dias*1440
    let minutos=minutos+q*60+p
    return minutos

end function


##########################

function aentero(s)
define s char(2),
       num integer

 let num=s[1,1]*10+s[2,2] 
 return num
end function

###################################

function ventanaprograma()
  define 
	 i     integer,
	 n     integer,
         cmd   char(100),
	 param like prgmodulos.prgnom,
	 c,s   integer,

	 ra array[500] of record 
			    prgnom like prgmodulos.prgnom,
			    nombre like prgmodulos.nombre
                          end record,

         r               record
			    prgnom like prgmodulos.prgnom,
			    nombre like prgmodulos.nombre
                         end record


  open window  f1 at 5,10 with form "fvpm" attribute (border,form line first+1)

   declare c4 cursor for select prgnom, nombre
			   from prgmodulos
                          order by nombre

   let i=0
   foreach c4 into r.*
       let i = i + 1
       let ra[i].prgnom = r.prgnom
       let ra[i].nombre = r.nombre
   end foreach

   call set_count(i)

   display array ra to rlp.* 

     on key (control-p)  
       let c=arr_curr()
       let s=scr_line()

       if acceso_programa(ra[c].prgnom) then

	let cmd = "fglgo /syspenal/",ra[c].prgnom clipped
	run cmd
       else 
	open window w1 at 18,53 with 3 rows, 20 columns 
	                                attribute (border, form line first)
          message " Usuario sin acceso"
          sleep 2
	close window w1

       end if

   end display 

   let n = arr_curr()    
   let param = ra[n].prgnom

  close window f1

  return param

end function

############################
function nombre_empresa()
  return "DEMO" 
end function
############################
function subnombre_empresa()
  return "demo" 
end function
############################
function nombre_tipo_producto()
  return "Libro" 
end function
############################

function ventana_lgs()
  define 
	 q1,q2 char(300),
	 i     integer,
	 n     integer,

	 ra array[500] of record 
			    linea char(8),
			    descr like nomelibro.descr
                         end record,

	 r               record 
			    linea like nomelibro.linea,
			    grupo like nomelibro.grupo,
			    subgr like nomelibro.subgr,
			    descr like nomelibro.descr
                         end record


  open window  f1 at 5,10 with form "fvlgs" 

   attribute (border,form line first+1,message line first)
   #message " Esc=iniciar busqueda"

   #construct by name q1 on nomelibro.linea, nomelibro.descr

   let q2="select linea, grupo, subgr, descr from nomelibro ",
          " order by linea, grupo, subgr" 

   prepare s10 from q2
   declare c10 cursor for s10

   let i=0
   foreach c10 into r.*
       let i = i + 1


       if r.grupo = 0 and r.subgr = 0 then
           let ra[i].linea = r.linea using "##"
           let ra[i].descr  = r.descr
       else
           if r.grupo <> 0  and r.subgr = 0 then
              let ra[i].linea = r.linea using "##",".", r.grupo using "##"
              let ra[i].descr  = " " , r.descr
           else
              let ra[i].linea = r.linea using "##",".", r.grupo using "##", ".",
                                r.subgr using "##"
              let ra[i].descr  = "  " , r.descr

           end if
       end if

       if i = 500 then
         error "existen mas datos"
         sleep 1
         exit foreach
       end if

   end foreach

   message " Esc=Salir"
   call set_count(i)
   display array ra to rli.* 

   let n = arr_curr()    
   let r.linea = ra[n].linea

  close window f1

  return r.linea

end function

############################
