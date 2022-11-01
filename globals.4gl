######################
database penado

######################

globals 
define
        rh   record like horario.*,
        rr   record like reserva.*,
        rl,l record like libros.*,
	rph  record like prestahea.*,
        rp   record like prestamos.*,
        ra   record like auxiliares.*,
        rll  record like lectores.*,
        rdp  record like depende.*,
	ri,
	ii   record like indice.*,
	rpg  record like pagos.*,
	rch  record like pagohea.*,
        rig  record like ingreso.*,
        rdi  record like ingrdeta.*,

        reg  record like egreso.*,
        rdeg  record like egredeta.*,

        rve  record like venta.*,
        rvd  record like vendeta.*,
	reh  record like recephea.*,
	re   record like recepcio.*,
              
       descrip0 char(30),
       descrip1 char(30),
       descrip2 char(30),
       descrip3 char(30),
       descrip4 char(30),

       descrip5 char(30),
       descrip6 char(30),
       descrip7 char(30),
       descrip8 char(30),
       descrip9 char(30),
       descrip10 char(30),
       descrip11 char(30),
       descrip12 char(30),

       rpa array[100] of record 
                          codlibro like libros.codlibro,
	                  cantpres decimal(05,0),
		          precio   decimal(10,2)
                        end record,

       rde array[500] of record like indice.*,

       rra array[100] of record 
                          nropresta like prestahea.nropresta,
	                  fechapres like prestahea.fechapres,
		          codlibro  like prestamos.codlibro,
			  cantpres  like prestamos.cantpres,
			  cantdevu  like prestahea.cantdevu
                        end record,

        rcj array[100] of record
                           nropresta like prestahea.nropresta,
			   codicpto  like pagos.codicpto,
			   fechareg  like prestahea.fechapres,
			   montodeu  like pagos.montopag,
			   montopag  like pagos.montopag,
                           nrofila   integer
			 end record,
        rrj              record
                           nropresta like prestahea.nropresta,
			   codicpto  like pagos.codicpto,
			   fechareg  like prestahea.fechapres,
			   montodeu  like pagos.montopag,
			   montopag  like pagos.montopag,
			   nrofila   integer
			 end record,

       rpi  array[100] of record 
                           codlibro like libros.codlibro,
                           caningre like ingrdeta.caningre,
                           cosingre like ingrdeta.cosingre,
                           totingre like ingrdeta.totingre
                         end record,
       rpe  array[100] of record 
                           codlibro like libros.codlibro,
                           canegres like egredeta.canegres,
                           cosegres like egredeta.cosegres,
                           totegres like egredeta.totegres
                         end record,

       rri               record 
                           codlibro like libros.codlibro,
                           caningre like ingrdeta.caningre,
                           cosingre like ingrdeta.cosingre,
                           totingre like ingrdeta.totingre
                         end record,

       rpv  array[100] of record 
                           codlibro like libros.codlibro,
                           canventa like ingrdeta.caningre,
                           preventa like ingrdeta.cosingre,
                           tovventa like ingrdeta.totingre
                         end record,

       rrv               record 
                           codlibro like libros.codlibro,
                           canventa like ingrdeta.caningre,
                           preventa like ingrdeta.cosingre,
                           tovventa like ingrdeta.totingre
                         end record,
       rpvd array[100] of record 
                           codlibro like libros.codlibro,
                           canventa like ingrdeta.caningre,
                           preventa like ingrdeta.cosingre,
                           tovventa like ingrdeta.totingre,
                           cantdevu like ingrdeta.caningre
                         end record,
        

        dna     integer,
        tiempoP integer,
        c       integer,
	s       integer,
        estado  integer,
	valido  integer,
        col     integer,
	bandera smallint,
	marca   smallint,
	mensaje char(80),
        codibarra smallint,

        condicion  char(200),
        comando    char(500)

end globals
