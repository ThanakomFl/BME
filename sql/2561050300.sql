create table organization_structure_images
(
  id         int auto_increment
    primary key,
  heading_th varchar(500) not null,
  heading_en varchar(500) not null,
  image_th   int          not null,
  image_en   int          not null,
  sequence   int          not null
)
  engine = MyISAM;

