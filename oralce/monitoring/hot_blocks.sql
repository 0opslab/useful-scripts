-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/hot_blocks.sql
-- Author       : DR Timothy S Hall
-- Description  : Detects hot blocks.
-- Call Syntax  : @hot_blocks
-- Last Modified: 17/02/2005
-- -----------------------------------------------------------------------------------
SET LINESIZE 200
SET VERIFY OFF

SELECT *
FROM   (SELECT name,
               addr,
               gets,
               misses,
               sleeps
        FROM   v$latch_children
        WHERE  name = 'cache buffers chains'
        AND    misses > 0
        ORDER BY misses DESC)
WHERE  rownum < 11;

ACCEPT address PROMPT "Enter ADDR: "

COLUMN owner FORMAT A15
COLUMN object_name FORMAT A30
COLUMN subobject_name FORMAT A20

SELECT *
FROM   (SELECT o.owner,
               o.object_name,
               o.subobject_name,
               o.object_type,
               bh.tch,
               bh.obj,
               bh.file#,
               bh.dbablk,
               DECODE(bh.class,1,'data block',
                               2,'sort block',
                               3,'save undo block',
                               4,'segment header',
                               5,'save undo header',
                               6,'free list',
                               7,'extent map',
                               8,'1st level bmb',
                               9,'2nd level bmb',
                               10,'3rd level bmb',
                               11,'bitmap block',
                               12,'bitmap index block',
                               13,'file header block',
                               14,'unused',
                               15,'system undo header',
                               16,'system undo block',
                               17,'undo header',
                               18,'undo block') AS class,
               DECODE(bh.state, 0,'free',
                                1,'xcur',
                                2,'scur',
                                3,'cr',
                                4,'read',
                                5,'mrec',
                                6,'irec',
                                7,'write',
                                8,'pi',
                                9,'memory',
                                10,'mwrite',
                                11,'donated') AS state
        FROM   x$bh bh,
               dba_objects o
        WHERE  o.data_object_id = bh.obj
        AND    hladdr = '&address'
        ORDER BY tch DESC)
WHERE  rownum < 11;
