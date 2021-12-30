Select REGEXP_SUBSTR('ASDB','[ASDB]+')
FROM DUAL;


SELECT REGEXP_SUBSTR(STR,'[^\,]+',1,ROWNUM)

FROM(
SELECT 'ȫ�浿,�ڱ浿,��������,�����ҹ�' STR
FROM DUAL)
CONNECT BY LEVEL<=REGEXP_COUNT(STR,',')+1;



SELECT VAR_STR ORG,
SUBSTR(VAR_STR,1,INSTR(VAR_STR,',',1,1)-1) COL1,
SUBSTR(VAR_STR,INSTR(VAR_STR,',',1,1)+1,INSTR(VAR_STR,',',1,2) - INSTR(VAR_STR,',',1,1)-1) COL2,
SUBSTR(VAR_STR,INSTR(VAR_STR,',',1,2)+1,INSTR(VAR_STR,',',1,3) - INSTR(VAR_STR,',',1,2)-1) COL3,
SUBSTR(VAR_STR,INSTR(VAR_STR,',',1,3)+1,INSTR(VAR_STR,',',1,4) - INSTR(VAR_STR,',',1,3)-1) COL4,
SUBSTR(VAR_STR,INSTR(VAR_STR,',',1,4)+1,INSTR(VAR_STR||',',',',1,5) - INSTR(VAR_STR,',',1,4)-1) COL5
FROM
(
SELECT 'ȫ�浿,��뵿,�ڱ浿,1233,456' VAR_STR
FROM DUAL);


SELECT    :JUMIN
,SUBSTR(:JUMIN,-1) PRT
,SUBSTR(11-MOD(SUM(SUBSTR(REPLACE(:JUMIN,'-'),ROWNUM,1)* 
        SUBSTR('234567892345',ROWNUM,1)),11),-1) CAL_PRT
,DECODE(SUBSTR(:JUMIN,-1)
        ,SUBSTR(11-MOD(SUM(SUBSTR(REPLACE(:JUMIN,'-'),ROWNUM,1)* 
        SUBSTR('234567892345',ROWNUM,1)),11),-1),'VALIDATE','INVALIDATE') VERIF
FROM DUAL
CONNECT BY LEVEL <= LENGTH(REPLACE(:JUMIN,'-'));

 


 
 
 
 
 
 SELECT LPAD('*',DECODE(SIGN(CNT/2-ROWNUM),-1,CNT-ROWNUM,ROWNUM),'*') NO
  
 FROM(
 SELECT  CASE WHEN 10<:CNT 
 THEN TRUNC(DECODE(MOD(:CNT,2),0,:CNT,:CNT+1),-1) ELSE 10 END CNT 
 FROM DUAL
 CONNECT BY LEVEL < CASE WHEN 10<:CNT 
 THEN TRUNC(DECODE(MOD(:CNT,2),0,:CNT,:CNT+1),-1) ELSE 10 END
 
 );
 SELECT LPAD('*',DECODE(SIGN(CNT/2-ROWNUM),-1,CNT-ROWNUM,ROWNUM),'*') NO
 FROM
 (
 SELECT CASE WHEN 10<:CNT THEN TRUNC(:CNT,-1) ELSE 10 END CNT FROM DUAL
 CONNECT BY LEVEL < CASE  WHEN 10<:CNT 
 THEN TRUNC(:CNT,-1) ELSE 10 END);
 
 
 SELECT 
  CASE WHEN MOD(:CNT,2)=1 THEN
 (LPAD('*',DECODE(SIGN(:CNT+1/2-ROWNUM),-1,:CNT+1-ROWNUM,ROWNUM),'*') FROM DUAL CONNECT BY LEVEL <=:CNT+1))
 ELSE
 (LPAD('*',DECODE(SIGN(:CNT/2-ROWNUM),-1,:CNT-ROWNUM,ROWNUM),'*') FROM DUAL CONNECT BY LEVEL <:CNT END));
 


SELECT DECODE(B.NO,1,NAME,2,CLASS,'�հ�') NAME
 ,SUM(KOR) KOR
 ,SUM(ENG) ENG
 ,SUM(MAT) MAT
 ,SUM(KOR+ENG+MAT) TOT
FROM EXAM_RSLT A, (
SELECT ROWNUM NO FROM DUAL
CONNECT BY LEVEL <=3
) B
GROUP BY DECODE(B.NO,1,NAME,2,CLASS,'�հ�')
ORDER BY KOR;


SELECT DECODE(GROUPING(CLASS)||GROUPING(NAME),'00',NAME,'01',CLASS,'TOT') NAME
 ,SUM(KOR) KOR
 ,SUM(ENG) ENG
 ,SUM(MAT) MAT
 ,SUM(KOR+ENG+MAT) TOT
FROM EXAM_RSLT

GROUP BY ROLLUP(CLASS,NAME)
ORDER BY TOT;





select * from user_views;


SELECT*FROM EXAM_RSLT;


SELECT NAME
,SUM(KOR) KOR
,SUM(ENG) ENG
,SUM(MAT) MAT
,SUM(KOR+ENG+MAT) TOT
FROM EXAM_RSLT A
GROUP BY CLASS,NAME
UNION ALL
SELECT CLASS
,SUM(KOR) KOR
,SUM(ENG) ENG
,SUM(MAT) MAT
,SUM(KOR+ENG+MAT) TOT
FROM EXAM_RSLT A
GROUP BY CLASS
UNION ALL
SELECT 'TOT'
,SUM(KOR) KOR
,SUM(ENG) ENG
,SUM(MAT) MAT
,SUM(KOR+ENG+MAT) TOT
FROM EXAM_RSLT A
GROUP BY NULL;

SELECT NVL(DECODE(NO,1,NAME,2,CLASS),'TOT') NAME
,SUM(KOR) KOR
,SUM(ENG) ENG
,SUM(MAT) MAT
,SUM(KOR+ENG+MAT) TOT
FROM EXAM_RSLT A,
(SELECT NO
FROM COPY_T
WHERE ROWNUM <=3)B
GROUP BY DECODE(NO,1,CLASS)
,DECODE(NO,1,NAME,2,CLASS)
ORDER BY MIN(NO),KOR;

SELECT DECODE(GROUPING(CLASS)||GROUPING(NAME),'00',NAME,'01',CLASS,'TOT') NAME
,SUM(KOR) KOR
,SUM(ENG) ENG
,SUM(MAT) MAT
,SUM(KOR+ENG+MAT) TOT
,GROUPING(CLASS)||GROUPING(NAME) GR
FROM EXAM_RSLT A
GROUP BY ROLLUP(CLASS,NAME)
ORDER BY GR,KOR;







SELECT ROWNUM NO, A.*
FROM( SELECT NAME,ENG FROM EX_TEST A 
ORDER BY ENG DESC) A;

SELECT MAX(DECODE(NO,1,NAME)) NAME
,MIN(DECODE(NO,1,ENG)) ENG
,ABS(MIN(DECODE(NO,1,ENG))-MIN(DECODE(NO,2,ENG))) CHA 
FROM(
SELECT NAME,NO,DECODE(NO,1,SEQ,SEQ+1) SEQ,ENG ENG
FROM(
SELECT ROWNUM SEQ,A.*
FROM
(
SELECT NAME,ENG FROM EX_TEST A ORDER BY ENG DESC,NAME) A ),(SELECT ROWNUM NO FROM DUAL CONNECT BY LEVEL <=2)
WHERE NO<=2 )
GROUP BY SEQ
HAVING MIN(DECODE(NO,1,ENG)) IS NOT NULL
ORDER BY SEQ;


SELECT NAME,NO,DECODE(NO,1,SEQ,SEQ+1) SEQ,ENG ENG
FROM(
SELECT ROWNUM SEQ,A.*
FROM
(
SELECT NAME,ENG FROM EX_TEST A ORDER BY ENG DESC,NAME) A ),(SELECT ROWNUM NO FROM DUAL CONNECT BY LEVEL <=2)
WHERE NO<=2;




SELECT NM

      ,MAX(SUBJECT)KEEP(DENSE_RANK LAST ORDER BY SCORE DESC) SUBJECT
      ,MIN(SCORE)
 FROM STD_SCORE
 GROUP BY NM
 ORDER BY NM;
 
 

 




	 
 

SELECT* FROM STD_SCORE,COURSE_CREDITS
WHERE SCORE BETWEEN ST_RNG AND ET_RNG 
ORDER BY NM,SCORE DESC;




 

SELECT NM,TO_CHAR(MIN
FROM QUIZE_SCORE 
GROUP BY NM,SCORE;











			SELECT TO_CHAR(MIN(DECODE(D_ID,1,M_ID)),'YYYY-MM') MID
,
MIN(DECODE(W_ID,1,D_ID))��
,MIN(DECODE(W_ID,2,D_ID))��
,MIN(DECODE(W_ID,3,D_ID))ȭ
,MIN(DECODE(W_ID,4,D_ID))��
,MIN(DECODE(W_ID,5,D_ID))��
,MIN(DECODE(W_ID,6,D_ID))��
,MIN(DECODE(W_ID,7,D_ID))��

FROM
(
SELECT A.M_ID,A.WK_ID,A.W_ID,A.D_ID
FROM(
SELECT 
TO_DATE(:V_ST,'YYYYMM')+ROWNUM-1 M_ID
,TRUNC(TO_DATE(:V_ST,'YYYYMM')+ROWNUM-1,'D') WK_ID
,TO_CHAR(TO_DATE(:V_ST,'YYYYMM')+ROWNUM-1,'D') W_ID 
,EXTRACT(DAY FROM TO_DATE(:V_ST,'YYYYMM')+ROWNUM-1) D_ID
FROM DUAL
CONNECT BY LEVEL <=
LAST_DAY(TO_DATE(:V_ET,'YYYYMM'))-TO_DATE(:V_ST,'YYYYMM')+1) A
WHERE MOD(EXTRACT(MONTH FROM M_ID),2) =:EVENODD) 

GROUP BY WK_ID
ORDER BY WK_ID;
	
	

	
SELECT MAX(DECODE(NO,1,NAME)) NAME
,MIN(DECODE(NO,1,ENG)) ENG
,ABS(MIN(DECODE(NO,1,ENG))-MIN(DECODE(NO,2,ENG))) CHA 
,SEQ
FROM(
SELECT NAME,NO,DECODE(NO,1,SEQ,SEQ+1) SEQ,ENG ENG
FROM(
SELECT ROWNUM SEQ,A.*
FROM
(
SELECT NAME,ENG FROM EX_TEST A ORDER BY ENG DESC,NAME) A ),(SELECT ROWNUM NO FROM DUAL CONNECT BY LEVEL <=2)
)
GROUP BY SEQ
HAVING MIN(DECODE(NO,1,ENG)) IS NOT NULL
ORDER BY SEQ;


SELECT NAME,NO,DECODE(NO,1,SEQ,SEQ+1) SEQ, ENG ENG 
FROM(SELECT ROWNUM SEQ,A.* FROM(SELECT NAME ,ENG FROM EX_TEST ORDER BY ENG DESC,NAME) A),(SELECT ROWNUM NO FROM DUAL CONNECT BY LEVEL <=2)
WHERE NO<=2;


SELECT NAME,NO,DECODE(NO,1,SEQ,SEQ+1) SEQ,ENG ENG
FROM(
SELECT ROWNUM SEQ,A.*
FROM
(
SELECT NAME,ENG FROM EX_TEST A ORDER BY ENG DESC,NAME) A ),(SELECT ROWNUM NO FROM DUAL CONNECT BY LEVEL <=2)
WHERE NO<=2;


SELECT NM,SUBJECT,SCORE,GRADE,ST_RNG,ET_RNG
FROM STD_SCORE S,COURSE_CREDITS C
WHERE S.SCORE BETWEEN C.ST_RNG AND C.ET_RNG
ORDER BY NM,SCORE DESC;

SELECT DECODE(NO,1,NAME,2,CLASS,'�հ�') NAME
,SUM(KOR) KOR
,SUM(ENG) ENG
,SUM(MAT) MAT
,SUM(KOR+ENG+MAT) TOT
FROM(
SELECT * FROM EXAM_RSLT,(SELECT ROWNUM NO FROM DUAL CONNECT BY LEVEL <=3))
GROUP BY DECODE(NO,1,NAME,2,CLASS,'�հ�')
ORDER BY KOR;