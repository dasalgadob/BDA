use dw_sakila;

drop procedure if exists dw_sakila.fill_table_dimension_date;
delimiter $$
CREATE  procedure `fill_table_dimension_date` ()
BEGIN

declare anio int  default 2010;
declare mes int default 1;
declare dia int default 1;
set anio = 2010;
while anio<2020 do
	set mes =1;
    while mes < 13 do
		set dia =1;
        while dia < 31 do
			
			insert into dim_date (date_year, date_month, date_day) values(anio, mes, dia);
            set dia = dia+1;
        end while;
        set mes = mes +1;
    end while;
    set anio = anio +1;
 
end while; 

END $$
delimiter ;

-- call fill_table_dimension_date();
/** 
use dw_sakila;
insert into dim_time(time_year, time_month, time_day, time_hour,time_minute, time_second) values(2018, 1, 1,1,1,1);


insert into dim_date (date_year, date_month, date_day) values(2010, 1, 1);
select * from dim_date order by date_year, date_month, date_day limit 10000;


select count(*) from dim_date;

**/ç