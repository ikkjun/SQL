create table t1 as select * from all_objects;
select * from t1;

create index t1_idx on t1(object_id);

select count(object_id) from t1;

exec dbms_stats.gather_table_stats(user, 't1');

set autotrace traceonly exp;

explain plan for
select * 
from t1
where owner = 'PUBLIC'
;

select * from table(dbms_xplan.display());

/*
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |  1328 |   160K|   124   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| T1   |  1328 |   160K|   124   (0)| 00:00:01 |
--------------------------------------------------------------------------
*/

explain plan for
select /*+index(t1 t1_idx) */ * from t1
where owner = 'PUBLIC'
;

select * from table(dbms_xplan.display());
/*
----------------------------------------------------------------------------------------------
| Id  | Operation                           | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |        |  1328 |   160K|   647   (1)| 00:00:01 |
|*  1 |  TABLE ACCESS BY INDEX ROWID BATCHED| T1     |  1328 |   160K|   647   (1)| 00:00:01 |
|   2 |   INDEX FULL SCAN                   | T1_IDX | 23910 |       |    53   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------
*/

explain plan for
select /*+full(t1) */ * from t1
where owner = 'PUBLIC'
;

select * from table(dbms_xplan.display());
/*
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |  1328 |   160K|   124   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| T1   |  1328 |   160K|   124   (0)| 00:00:01 |
--------------------------------------------------------------------------
*/