use dw_delitos;
drop table if exists r;
	create  table r
(fecha varchar(45), departamento varchar(45), municipio varchar(45),
 dia varchar(45), hora varchar(45), barrio varchar(45),
 zona varchar(45),
 clase_sitio varchar(45), arma_empleada varchar(45), movil_agresor varchar(45),
 movil_victima varchar(45), edad varchar(45) , sexo varchar(45), estado_civil varchar(45),
 pais_nace varchar(45), clase_empleado varchar(45), profesion varchar(45), escolaridad varchar(45),
 codigo_dane varchar(45), anio varchar(45));
 
 drop table if exists t;
 create  table t (test varchar(45));
 
 
LOAD DATA INFILE 'r2010.csv'
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
	DECLARE fecha_VAL varchar(45) DEFAULT "";
	DECLARE iterate_file CURSOR FOR 
    select fecha from r limit 2 ;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN iterate_file;
    select fecha from r limit 2 ;
    read_loop: LOOP
		FETCH iterate_file INTO fecha_VAL;
        
        IF done THEN
			lEAVE read_loop;
		END IF;
        insert into t(test) values(fecha_VAL);
    END LOOP;
    close iterate_file;
    -- drop table r;
end // 

call residencias();


select count(*) from t;

select * from t;
