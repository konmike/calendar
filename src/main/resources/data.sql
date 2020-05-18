INSERT INTO role (id,name)
SELECT *
from (values (1,'ROLE_USER')) as x(id,name)
WHERE NOT EXISTS (SELECT 1
                  FROM role t
                  where t.id = x.id);

INSERT INTO role (id,name)
SELECT *
from (values (2,'ROLE_ADMIN')) as x(id,name)
WHERE NOT EXISTS (SELECT 2
                  FROM role t
                  where t.id = x.id);

--INSERT INTO role (id, name) VALUES  (1, 'ROLE_USER'),  (2, 'ROLE_ADMIN');
