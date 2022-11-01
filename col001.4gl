globals "globals.4gl"
################################

define  res record like est.*,
        rap record like apodera.*,
        rea record like est_adj.*,
        raa record like apo_adj.*,
        opcion1  char,
        opcion2  char,
        opcion3  char,
        opcion4  char,

        desapode char(40),
        despadre char(40),
        desmadre char(40),

        desnac    char(40),
        despro    char(40)

main

  defer interrupt
  defer quit

   open form f1  from "fcol1"
   display form f1

   call titulo("Manteminiento de Estudiantes")

   let bandera = 0


  menu "COL001"
     before menu

      hide option "Proximo","Anterior","Primero","Ultimo",
		  "Modificar","Eliminar"

     command "Adicionar" "Adicinar lectores"
       call alector()

     command "Consultar" "Consultar lectores"
        call clector()

     if marca then 
       error mensaje
     else
	show option "Proximo","Anterior","Primero","Ultimo",
		    "Modificar","Eliminar"
	hide option "Adicionar","Consultar"
	let bandera = 1

     end if


  command "Proximo"
     call proximo()

  command "Anterior"
     call anterior()

  command key(r) "Primero"
     call primero()

  command "Ultimo"
     call ultimo()

  command "Modificar"
	call molector()

        call actualizar_cursor()

    if marca then 
       call primero()
       next option "Proximo"
    else
        error mensaje

	hide option "Proximo","Anterior","Primero","Ultimo",
		    "Modificar","Eliminar"
	show option "Adicionar","Consultar"
	let bandera = 0

    end if

  command "eliminar"
	call dlector()
        call actualizar_cursor()

    if marca then 
       call primero()
       next option "Proximo"
    else
        error mensaje

	hide option "Proximo","Anterior","Primero","Ultimo",
		    "Modificar","Eliminar"
	show option "Adicionar","Consultar"
	let bandera = 0

    end if


     command "Salir"

    if bandera = 0 then 
      exit menu
    else
       clear form
	hide option "Proximo","Anterior","Primero","Ultimo",
		    "Modificar","Eliminar"
	show option "Adicionar","Consultar"
	let bandera = 0

    end if

  end menu

end main

################################

function alector()

 define salir char

 #whenever error continue

    call teclas_registro_ayuda()
    call limpiar_varLE()

 while true
    clear form


    while true

    input by name res.reg, rea.grpsan, res.nombre, 
                  res.direc, res.telef ,  res.fecha_nac, 
		  res.sexo, res.email, rea.casill, 
                  res.pais_nac, res.dpto_nac,
                  res.nacionalidad, res.nacionalida2,
                  res.religion, rea.fingre, res.col_origen,
                  opcion1,
                  res.fecha_ret, res.cod_ret,
                  rea.beca, res.curso_act, res.grupo_act, res.gest_act,
                  res.cate, res.cod_pad, rea.padre, rea.madre,
                  opcion2, opcion3, opcion4,
                  rea.viveco, rea.llamar
               without defaults

      on key (control-i)
        exit input

      on key (control-g)
        exit input

      on key (control-p)
          call ventana_parentesco()  

          let descrip10 = nom_apoderado(res.cod_pad)       
          display by name descrip10
          let descrip11 = nom_apoderado(rea.padre)       
          display by name descrip11
          let descrip12 = nom_apoderado(rea.madre)       
          display by name descrip12

      on key (control-w)
 
	if infield(pais_nac) then
	   let res.pais_nac = ventana_pais()
	   display by name res.pais_nac
	end if
 
	if infield(dpto_nac) then
	   let res.dpto_nac = ventana_dpto(res.pais_nac)
	   display by name res.dpto_nac
	end if
 
	if infield(nacionalidad) then
	   let res.nacionalidad = ventana_nacionalidad()
	   display by name res.nacionalidad
	end if

	if infield(nacionalida2) then
	   let res.nacionalida2 = ventana_nacionalidad()
	   display by name res.nacionalida2
	end if

	if infield(religion) then
	   let res.religion = ventana_religion()
	   display by name res.religion
	end if

	if infield(cod_ret) then
	   let res.cod_ret = ventana_retiro()
	   display by name res.cod_ret
	end if

	if infield(col_origen) then
	   let res.col_origen = ventana_colegio_origen()
	   display by name res.col_origen
	end if

	if infield(beca) then
	   let rea.beca= ventana_beca()
	   display by name rea.beca
	end if

       if infield(opcion2) then
           call mostrar_apoderado(res.cod_pad) 
       end if

       if infield(opcion3) then
           call mostrar_apoderado(rea.padre) 
       end if

       if infield(opcion4) then
           call mostrar_apoderado(rea.madre) 
       end if
 
      after field pais_nac
	 let descrip0 = des_pais(res.pais_nac)
	 display by name descrip0
 
      after field dpto_nac
	 let descrip2 = des_dpto(res.pais_nac, res.dpto_nac)
	 display by name descrip2
 
      after field nacionalidad
	 let descrip3 = des_nacionalidad(res.nacionalidad)
	 display by name descrip3

      after field nacionalida2
	 let descrip4 = des_nacionalidad(res.nacionalida2)
	 display by name descrip4

      after field religion
	 let descrip5 = des_religion(res.religion)
	 display by name descrip5

      after field cod_ret
	 let descrip6 = des_retiro(res.cod_ret)
	 display by name descrip6

      after field col_origen
	 let descrip8 = des_colegio_origen(res.col_origen)
	 display by name descrip8

      after field beca
	 let descrip7 = des_beca(rea.beca)
	 display by name descrip7

 
    end input

       if fgl_lastkey() = fgl_keyval("control-i") then
	  clear form
	  return
       end if

       if fgl_lastkey() = fgl_keyval("control-g") then
	  exit while
       end if

 end while

   call  validar_datos()
   if not valido then
     continue while
   end if   

    begin work
      let estado = 0

      let res.reg = 0
      let res.a_b = 0

      insert into est values(res.*)
      if status <> 0 then
        let estado = status
      end if

      let res.reg = sqlca.sqlerrd[2]

      let rea.reg = res.reg

      insert into est_adj values(rea.*)
      if status <> 0 then
        let estado = status
      end if

    if estado = 0 then
        commit work

        call limpiar_varLE1()

        display by name rea.reg
    else 
        error "Ha ocurrio el error : ",estado
        sleep 1
        rollback work 
    end if

 end while

end function 

###############################
    
function validar_datos()

  let valido = false

  if res.nombre is null then
     error "Nombre es requerido"
     return
  end if

  if res.direc is null then
     error "Direccion es requerida"
     return
  end if

  if res.telef is null then
     error "Telefono es requerido"
     return
  end if

  if res.fecha_nac is null then
     error "Fecha nacimiento es requerida"
     return
  end if

  if res.cod_pad is null then
    error "Apoderado es requerido"
    return
  end if

  if not existe_apoderado(res.cod_pad) then
    error "Apoderado no existe"
    return
  end if

  if rea.padre is null then
    error "Padre es requerido"
    return
  end if

  if not existe_apoderado(rea.padre) then
    error "Padre no existe"
    return
  end if

  if rea.madre is null then
    error "Madre es requerido"
    return
  end if

  if not existe_apoderado(rea.madre) then
    error "Madre no existe"
    return
  end if


  if res.pais_nac is null then
    error "Pais nacimiento es requerido"
    return
  end if

  if not existe_pais(res.pais_nac) then
    error "Pais nacimiento no existe"
    return
  end if

  if res.dpto_nac is null then
    error "Dpto nacimiento es requerido"
    return
  end if

  if not existe_dpto(res.dpto_nac, res.pais_nac) then
    error "Dpto de nacimiento no existe"
    return
  end if

  if res.nacionalidad is null then
    error "Nacionalidad es requerida"
    return
  end if

  if not existe_nacion(res.nacionalidad) then
    error "Nacionalidad no existe"
    return
  end if

{
  if res.idioma_m is null then
    error "Idioma es requerido"
    return
  end if

  if not existe_idioma(res.idioma_m) then
    error "Idioma no existe"
    return
  end if

}

  if res.religion is null then
    error "Religion es requerida"
    return
  end if

  if not existe_religion(res.religion) then
    error "Religion no existe"
    return
  end if

  if res.cod_ret is null then
    error "Tipo retiro es requerido"
    return
  end if

  let valido = true

end function

#####################

function limpiar_varLE()
  initialize rll.* to null
end function
###############################

function limpiar_varLE1()
  initialize res.* to null
  initialize rea.* to null
end function

###############################

# pedazo

function clector()

define s,q char(300)

 #whenever error continue


   call teclas_consulta()


while true

 construct by name q on codlec, cbarlec, nomlec
    on key (control-i) 
       exit construct

    on key (control-g) 
       exit construct

 end construct

       if fgl_lastkey() = fgl_keyval("control-i") then
          #close window wclc
	  let mensaje = "Proceso cancelado"
	  return
       end if

       if fgl_lastkey() = fgl_keyval("control-g") then
	  exit while
       end if

end while


 let s="select * from lectores  where ",q clipped,
       "order by codlec"

 prepare sc from s

 declare qc scroll cursor with hold for sc
 open qc

 fetch first qc into rll.*
 if status=notfound then
    let mensaje = "No existen datos"
    let marca = true

    initialize rll.* to null
    clear form

    return
end if

 call mostrar_datos_le()
 let marca = false

 end function

function actualizar_cursor()

 close qc
 open qc
 fetch first qc into rll.*

 if status=notfound then
    let mensaje = "no existen datos"
    let marca = false

    initialize rll.* to null
    clear form

 else 
    let marca = true
 end if

end function

 
function  proximo()

     fetch next qc into rll.*
     if status=notfound then
	let mensaje = "No existen datos"
	error mensaje  
        fetch last qc into rll.*
     end if
 call mostrar_datos_le()

end function

function anterior()

      fetch previous qc into rll.*
      if status= notfound    then
	let mensaje = "No existen datos"
	error mensaje  
        fetch first qc into rll.*
      end if
 call mostrar_datos_le()

end function

function primero()
      fetch first qc into rll.*
      call mostrar_datos_le()
end function


function ultimo()
      fetch last qc into rll.*
      call mostrar_datos_le()
end function


##############

function melector()

define s,q char(300)

 #whenever error continue

 open window wmlc at 4,5 with form "flec" attribute (border)

 display " Introduzca su criterio de Consulta " at 1,1
 call clear_menu()

 while true
 construct by name q on codlec, cbarlec, nomlec
    on key (control-i)
       exit construct

    on key (control-g)
       exit construct
 end construct

       if fgl_lastkey() = fgl_keyval("control-i") then
          close window wmlc
	  return
       end if

       if fgl_lastkey() = fgl_keyval("control-g") then
	  exit while
       end if

 end while


 let s="select * from lectores  where ",q clipped,
       "order by codlec"

 prepare sm from s

 declare qm scroll cursor with hold for sm
 open qm

 fetch first qm into rll.*
 if status=notfound then
    message "no existen mas registros"
    sleep 2
 else
    call mostrar_datos_le()

 menu "HOJEAR"

  command key(p) "Proximo"
     fetch next qm into rll.*
     if status=notfound then
	message "no existen mas registros"
	sleep 2

     end if
     call mostrar_datos_le()

  command "Anterior"
      fetch previous qm into rll.*
      if status= notfound    then
	message "no existen mas registros"
	sleep 2
      end if
      call mostrar_datos_le()

  command key(r) "pRimero "
      fetch first qm into rll.*
      call mostrar_datos_le()

  command "Ultimo"
      fetch last qm into rll.*
      call mostrar_datos_le()

  command "Modificar"
	call molector()

  command "eliminar"
	call dlector()


  command "Salir" "Salir del menu HOJEAR"
    exit menu
 end menu
end if
 close window wmlc
end function

##############

function molector()

 #whenever error continue

 call teclas_modificar_ayuda()

 while true

 input by name rll.cbarlec, rll.catgria, rll.nomlec, 
	       rll.ubicgeo, rll.direlec, rll.fonolec, rll.estalec
	       without defaults
 
  on key (control-i)
    exit input
     
  on key (control-g)
    exit input

  on key (control-w)

	if infield(catgria) then
	   let rll.catgria = ventanaparametro(25,25)
	   display by name rll.catgria
	end if

	if infield(ubicgeo ) then
	   let rll.ubicgeo = ventanaparametro(26,26)
	   display by name rll.ubicgeo
	end if

	if infield(estalec) then
	   let rll.estalec = ventanaparametro(98,98)
	   display by name rll.estalec
	end if


      after field catgria
	 let descrip0 = nomparametro(rll.catgria)
	 display by name descrip0

      after field ubicgeo
	 let descrip1 = nomparametro(rll.ubicgeo)
	 display by name descrip1

      after field estalec
	 let descrip2 = nomparametro(rll.estalec)
	 display by name descrip2


 end input

       if fgl_lastkey() = fgl_keyval("control-i") then
	  return
       end if

       if fgl_lastkey() = fgl_keyval("control-g") then
	  exit while
       end if

 end while

  begin work
  let estado = 0

     update lectores
       set 
	   cbarlec = rll.cbarlec,
           nomlec  = rll.nomlec,
           direlec = rll.direlec,
	   fonolec = rll.fonolec,
	   ubicgeo = rll.ubicgeo,
	   catgria = rll.catgria,
	   estalec = rll.estalec
	where codlec = rll.codlec

   if status <>0 then
     let estado = status
   end if

 if estado = 0 then
        commit work
 else
        error "ha ocurrido en error : ",estado
	sleep 1
	rollback work
 end if

end function

#############

function dlector()

 #whenever error continue

 call teclas_eliminar()

 while true

 input by name rll.cbarlec, rll.nomlec, rll.fonolec without defaults
 
  on key (control-i)
    exit input
  on key (control-g)
    exit input

 end input

       if fgl_lastkey() = fgl_keyval("control-i") then
	  return
       end if

       if fgl_lastkey() = fgl_keyval("control-g") then
	  exit while
       end if

 end while
  
 begin work

   let estado = 0

      delete from lectores
       where codlec = rll.codlec

      if status <>0 then
	let estado = status
      end if

 if estado = 0 then
	  commit work
 else 
    error "Ha ocurrido el error : ",estado
    sleep 1
    rollback work
 end if

end function

#####################

function mostrar_datos_le()
  display by name rll.codlec, rll.cbarlec,rll.nomlec, rll.cilec, 
		  rll.direlec, rll.fonolec, rll.ubicgeo, rll.catgria,
		  rll.estalec

  let descrip0 = nomparametro(rll.catgria)
  let descrip1 = nomparametro(rll.ubicgeo)
  let descrip2 = nomparametro(rll.estalec)
  display by name descrip0, descrip1, descrip2

end function
#####################

function ventana_parentesco()

  define 
         r    record
		apode like est_adj.apode,
                padre like est_adj.padre,
                madre like est_adj.madre 
              end record

  open window  f1 at 13,10 with form "fcol1a"
	    attribute (border,form line first+1,message line first)

   message "       Relacion parentesco "

   let r.apode = res.cod_pad
   let r.padre = rea.padre
   let r.madre = rea.madre

        let desapode = nom_apoderado(r.apode) 
        display by name desapode

        let despadre = nom_apoderado(r.padre) 
        display by name despadre

        let desmadre = nom_apoderado(r.madre) 
        display by name desmadre


   input by name r.* without defaults
     on key (control-i)
        exit input
     on key (control-w)

	if infield(apode) then
	   let r.apode = ventana_apoderado()
	   display by name r.apode
	end if

	if infield(padre) then
	   let r.padre = ventana_apoderado()
	   display by name r.padre
	end if

	if infield(madre) then
	   let r.madre = ventana_apoderado()
	   display by name r.madre
	end if

     after field apode   
        let desapode = nom_apoderado(r.apode) 
        display by name desapode

     after field padre
        let despadre = nom_apoderado(r.padre) 
        display by name despadre

     after field madre
        let desmadre = nom_apoderado(r.madre) 
        display by name desmadre

   end input

  close window f1

  let res.cod_pad = r.apode
  let rea.padre = r.padre
  let rea.madre = r.madre

end function

############################

function mostrar_apoderado(cod)

  define 
         cod  integer,
         r    record
		cod      like apodera.cod,
		nombre   like apodera.nombre,
		direc    like apodera.direc,
		telef    like apodera.telef,
		telf_emp like apodera.telf_emp,
		celula   like apo_adj.celula,
		mail     like apo_adj.mail,
		casill   like apo_adj.casill,
		grado    like apodera.grado,
		cod_prof like apodera.cod_prof,
		pais_nac like apodera.pais_nac,
		teleme   like apo_adj.teleme,
		ocupac   like apo_adj.ocupac
              end record

  open window  f2 at 5,3 with form "fcol1b"
	    attribute (border,form line first+1,message line first)

   message "       Apoderado " 

   call datos_apoderado()

   input by name r.* without defaults
     on key (control-w)

	if infield(pais_nac) then
	   let r.pais_nac = ventana_pais()
	   display by name r.pais_nac
	end if
     
	if infield(cod_prof) then
	   let r.cod_prof= ventana_profesion()
	   display by name r.cod_prof
	end if

     after field pais_nac
        let desnac = des_nacionalidad(r.pais_nac) 
        display by name desnac

     after field cod_prof
        let despro = des_profesion(r.cod_prof) 
        display by name despro


   end input

  close window f2


end function

############################
function datos_apoderado()

end function
############################
