globals "globals.4gl"

#################################

function titulo(s)
  define s     char(60),
	 fecha date,
	 lon   smallint

  call control_usuario()

  call fgl_drawbox(20,80,3,1)         

  let s= "@", s clipped
  let fecha = date

  display s at 4,2 attribute(reverse)
  display fecha at 4,70 attribute(reverse)

 # if fecha <"05/06/2002" or fecha >"10/06/2002" then
 #    clear screen
 #   display "SYSPENAL: "
 #   display "Periodo de prueba expirado"
 #   display " "
 #   exit program
 #end if

  let codibarra = false

end function

#################################

function control_usuario()
  define nombredb char(20)

  let nombredb=FGL_GETENV("DBSNAME")
  if nombredb is null then
     let nombredb="penado"
  end if  

  close database
  database nombredb

end function
#################################

function teclas_registro()

  display "" at 2,1
  display "Control: I=Interumpir, G=Grabar" at 2,1

end function

function teclas_registro_ayuda()

  display "" at 2,1
  display "Control: I=Interumpir, G=Grabar,W=Ventana" at 2,1

end function

#################################

function teclas_consulta()

  display "" at 2,1
  display "Control: I=Interumpir, G=Buscar" at 2,1

end function

#################################

function teclas_eliminar()

  display "" at 2,1
  display "Control: I=Interumpir, G=Eliminar" at 2,1

end function

#################################

function teclas_modificar()

  display "" at 2,1
  display "Control: I=Interumpir, G=Modificar" at 2,1

end function

function teclas_modificar_ayuda()

  display "" at 2,1
  display "Control: I=Interumpir, G=Modificar,W=ventana" at 2,1

end function

#################################

function teclas_generar()

  display "" at 2,1
  display "Control: I=Interumpir, G=Generar" at 2,1

end function

#################################


################################
{ 
 
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
function nombre_empresa1()
  return "SIBIO S.A."
end function
############################
function nombre_empresa2()
  return "  "
end function
############################
}
