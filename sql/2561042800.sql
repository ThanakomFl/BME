create table staffs
(
  id        int auto_increment
    primary key,
  name_th   varchar(500) not null,
  name_en   varchar(500) not null,
  type      int          not null,
  picture   int          not null,
  detail_th text         not null,
  detail_en text         not null
)
  engine = MyISAM;