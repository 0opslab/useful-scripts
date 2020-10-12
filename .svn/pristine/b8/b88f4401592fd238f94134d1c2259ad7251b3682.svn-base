-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/longops.sql
-- Author       : DR Timothy S Hall
-- Description  : Displays information on all long operations.
-- Requirements : Access to the V$ views.
-- Call Syntax  : @longops
-- Last Modified: 05/07/2007
--
-- Thanks to Will Rose for noticing my mistake in using ROUND rather than TRUNC when
-- calculating seconds.
-- -----------------------------------------------------------------------------------

COLUMN sid FORMAT 999
COLUMN serial# FORMAT 9999999
COLUMN machine FORMAT A30
COLUMN progress_pct FORMAT 99999999.00
COLUMN elapsed FORMAT A10
COLUMN remaining FORMAT A10

SELECT s.sid,
       s.serial#,
       s.machine,
       TRUNC(sl.elapsed_seconds/60) || ':' || MOD(sl.elapsed_seconds,60) elapsed,
       TRUNC(sl.time_remaining/60) || ':' || MOD(sl.time_remaining,60) remaining,
       ROUND(sl.sofar/sl.totalwork*100, 2) progress_pct
FROM   v$session s,
       v$session_longops sl
WHERE  s.sid     = sl.sid
AND    s.serial# = sl.serial#;
