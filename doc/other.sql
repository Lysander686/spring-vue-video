update course c set`time` = (select sum(`time`) from `section` where course_id='00000001') where c.id='00000001'