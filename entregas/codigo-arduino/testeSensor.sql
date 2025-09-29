use testesensor;

create table temperatura(
	idtemperatura int primary key auto_increment,
    temp decimal(3,1)
);

insert into temperatura (temp) values
	(21.8);
    
    select * from temperatura;