use dw_delitos;

alter table `dw_delitos`.`hecho_delito` modify column `clase_sitio` varchar(300);



INSERT INTO `dw_delitos`.`dim_objeto`
(
`clase`,
`marca`,
`linea`,
`modelo`,
`color`)
VALUES
(
'Ninguna',
'Ninguna',
'Ninguna',
'Ninguna',
'Ninguna');


drop table if exists r;
	create  table r
(fecha varchar(45), departamento varchar(45), municipio varchar(45),
 dia varchar(45), hora varchar(45), barrio varchar(45),
 zona varchar(45),
 clase_sitio varchar(300), arma_empleada varchar(45), movil_agresor varchar(45),
 movil_victima varchar(45), edad varchar(45) , sexo varchar(45), estado_civil varchar(45),
 pais_nace varchar(45), clase_empleado varchar(45), profesion varchar(45), escolaridad varchar(45),
 codigo_dane varchar(45), anio varchar(45));
 
 -- drop table if exists t;
 -- create  table t (test varchar(45));
 
 
LOAD DATA INFILE 'p2014.csv'
INTO TABLE r 
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

delete from r where departamento='';

select fecha from r limit 2 ;

-- select * from t;

drop procedure if exists residencias;
delimiter //
create procedure residencias()
begin 
	
	DECLARE done INT DEFAULT FALSE;
	DECLARE fecha_VAL,departamento_VAL , municipio_VAL,
	dia_VAL , hora_VAL , barrio_VAL,zona_VAL,
	clase_sitio_VAL, arma_empleada_VAL, movil_agresor_VAL,
	movil_victima_VAL, edad_VAL, sexo_VAL, estado_civil_VAL,
	pais_nace_VAL, clase_empleado_VAL, profesion_VAL, escolaridad_VAL varchar(45) DEFAULT "";
    
    -- Variables for ids for the datawarehouse
    declare fecha_id_val, id_geografia_val int default 0;
    declare id_objeto_val int default 1;
    declare out_param int default 0;
    declare count_records int default 0;
    declare edad_final int default 0;
    
	DECLARE iterate_file CURSOR FOR 
    select fecha , departamento , municipio ,
	dia , hora , barrio ,zona , clase_sitio, arma_empleada, movil_agresor,
	movil_victima , edad , sexo , estado_civil ,
	pais_nace , clase_empleado, profesion , escolaridad from r limit 100 ;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN iterate_file;
    
    /*select fecha , departamento , municipio ,
			dia , hora , barrio ,
		zona , clase_sitio, arma_empleada, movil_agresor,
	 movil_victima , edad , sexo , estado_civil ,
	 pais_nace , clase_empleado, profesion , escolaridad from r limit 2 ;*/
     -- se iteran en todos los registros del archivo
    read_loop: LOOP
		FETCH iterate_file INTO fecha_VAL,departamento_VAL , municipio_VAL,
		dia_VAL , hora_VAL , barrio_VAL,zona_VAL,
		clase_sitio_VAL, arma_empleada_VAL, movil_agresor_VAL,
		movil_victima_VAL, edad_VAL, sexo_VAL, estado_civil_VAL,
		pais_nace_VAL, clase_empleado_VAL, profesion_VAL, escolaridad_VAL;
        
        IF done THEN
			lEAVE read_loop;
		END IF;
        -- se consigue fecha id para saber cual id de d_date usar
        set fecha_id_val = concat( substring(fecha_VAL, 7,4), substring(fecha_VAL, 4,2), substring(fecha_VAL, 1,2));
        
        if edad_VAL = 'NO REPORTADO'  then
        set edad_final=0;
        end if;
        -- se inserta denunciante y se obtiene el id de insercion
        begin 
        
        INSERT INTO `dw_delitos`.`dim_denunciante`
			(`edad`, `movilizacion`,`sexo`,`estado_civil`,`pais_nacimiento`,`clase_empleado`,
			`escolaridad`,`ocupacion`)
		VALUES
			(edad_final,movil_victima_VAL,sexo_VAL,estado_civil_VAL,pais_nace_VAL,clase_empleado_VAL,escolaridad_VAL,
			profesion_VAL);

        SET out_param = LAST_INSERT_ID();
        end;
        
        -- si ya existe geografia se usa y si no se crea
        select count(*) into count_records from dim_geografia where barrio= barrio_VAL and departamento=departamento_VAL
        and municipio = municipio_VAL;
        if count_records >0 then
			-- usar id del existente
            select id_geografia into id_geografia_val from dim_geografia where barrio= barrio_VAL and departamento=departamento_VAL
        and municipio = municipio_VAL;
        else
			begin
			INSERT INTO `dw_delitos`.`dim_geografia`
			(`departamento`,`zona`,`municipio`,`barrio`,`localidad`)
			VALUES
			(departamento_VAL,zona_VAL,municipio_VAL,barrio_VAL,'');
            SET id_geografia_val = LAST_INSERT_ID();
			end;

        end if;
        INSERT INTO `dw_delitos`.`hecho_delito`
		(`tipo_delito`,`arma_empleada`,`movilidad_del_agresor`,`clase_sitio`,`cantidad`,`id_denunciante`,`id_objeto`,`id_geografia`,
		`id_date`)
		VALUES
		('HURTO A PERSONAS',
		arma_empleada_VAL,
		movil_agresor_VAL,
		clase_sitio_VAL,
		1,
		out_param,
		id_objeto_val,
		id_geografia_val,
		fecha_id_val);

        -- select out_param;
        -- insert into t(test) values(fecha_id_val);
    END LOOP;
    close iterate_file;
    -- drop table r;
end // 

call residencias();


select count(*) from t;

select * from t;
