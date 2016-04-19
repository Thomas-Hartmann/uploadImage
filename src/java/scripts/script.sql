DROP TABLE if exists save_image;
CREATE TABLE save_image (             
              id int(5) NOT NULL auto_increment,  
              name varchar(25) default NULL,       
              image blob,                         
              PRIMARY KEY  (`id`)                   
 );
