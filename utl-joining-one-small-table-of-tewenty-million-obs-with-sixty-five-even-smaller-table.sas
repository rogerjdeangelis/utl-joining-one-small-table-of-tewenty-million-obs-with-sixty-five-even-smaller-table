%let pgm=utl-joining-one-small-table-of-tewenty-million-obs-with-sixty-five-even-smaller-table;

Join a 20 million record datasets with 352 columns with 65 tables with 7 colums and 7000 observations

For these small tables the join to produce the 65 tables took less than a minute.

NO NEED FOR MULTI-TASKING

github
https://tinyurl.com/4sunt9v8
https://github.com/rogerjdeangelis/utl-joining-one-small-table-of-tewenty-million-obs-with-sixty-five-even-smaller-table

StackOverflow
https://tinyurl.com/mujxues7
https://stackoverflow.com/questions/76137005/how-to-efficiently-join-many-small-tables-to-a-large-table-in-sql

I assume there is a primary key on the big table. Required by some relatonal databases.
Join a 20 million record datasets with 352 columns with 65 tables with 7 colums
The result is 65 tables with all data from the 20 million table.

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

/*---- create 20 million obs with 350 columns                     ----*/
libname sd1 "m:/sd1";

 data sd1.havBig(index=(priKey/unique));;
   retain priKey 0 grp;
   array cols[350] 3 dates1-dates350  (350*'03MAY2023'd);
   do _n_=1 to 20000000;
      grp=abs(mod(_n_,100) - _n_);
      priKey=priKey+7;
      output;
   end;
 run;quit;

/*---- real time           32.05 seconds                          ----*/

 %array(_seq,values=1-65);

 data %do_over(_seq,phrase=a?);

      retain prikey 0;
      array cols[6] 3 dte1-dte6  (6*'31DEC2022'd);

      set sd1.havBigIdx(drop=grp where=(uniform(12345)<7000/20000000<.5));

        %do_over(_seq,phrase=%str(
           priKey=prikey + ?; output a?;
           ));
 run;quit;

/*---- real time           5.71 seconds                           ----*/

/*----
/*---- Data set WORK.A1 has 7059 observations and 7 variables     ----*/
/*---- Data set WORK.A2 has 7059 observations and 7 variables     ----*/
/*---- Data set WORK.A3 has 7059 observations and 7 variables     ----*/
/*----
/*---- Data set WORK.A63 has 7059 observations and 7 variables    ----*/
/*---- Data set WORK.A64 has 7059 observations and 7 variables    ----*/
/*---- Data set WORK.A65 has 7059 observations and 7 variables    ----*/


/**************************************************************************************************************************/
/*                                                                                                                        */
/* SMALL 20 MILLION ROW TABLE                                                                                             */
/*                                                                                                                        */
/* Middle Observation(10,000,000 ) of table = sd1.havBig - Total Obs 20,000,000 03MAY2023:15:28:00                        */
/*                                                                                                                        */
/*  -- NUMERIC --                                                                                                         */
/* PRIKEY              N8        70000000                                                                                 */
/* GRP                 N8        10000000                                                                                 */
/* DATES1              N3           23132                                                                                 */
/* DATES2              N3           23132                                                                                 */
/* DATES3              N3           23132                                                                                 */
/* ....                                                                                                                   */
/* DATES348            N3           23132                                                                                 */
/* DATES349            N3           23132                                                                                 */
/* DATES350            N3           23132                                                                                 */
/*                                                                                                                        */
/* Alphabetic List of Indexes and Attributes                                                                              */
/*                                                                                                                        */
/*                              # of                                                                                      */
/*                Unique      Unique                                                                                      */
/* #    Index     Option      Values                                                                                      */
/*                                                                                                                        */
/* 1    PRIKEY    YES       20000000                                                                                      */
/*                                                                                                                        */
/*                                                                                                                        */
/* 65 VERY SMALL TABLES                                                                                                   */
/*                                                                                                                        */
/* Middle Observation(3529 ) of table = a1 - Total Obs 7,059 03MAY2023:15:32:07                                            */
/*                                                                                                                        */
/*  -- NUMERIC --                                                                                                         */
/* PRIKEY              N8         9930556                                                                                 */
/* DTE1                N3           23008                                                                                 */
/* DTE2                N3           23008                                                                                 */
/* DTE3                N3           23008                                                                                 */
/* DTE4                N3           23008                                                                                 */
/* DTE5                N3           23008                                                                                 */
/* DTE6                N3           23008                                                                                 */
/*                                                                                                                        */
/* .... 63 OTHER TABLES                                                                                                   */
/*                                                                                                                        */
/* Middle Observation(3529 ) of table = a65 - Total Obs 7,059 03MAY2023:15:50:29                                          */
/*                                                                                                                        */
/*  -- NUMERIC --                                                                                                         */
/* PRIKEY              N8         9932700                                                                                 */
/* DTE1                N3           23008                                                                                 */
/* DTE2                N3           23008                                                                                 */
/* DTE3                N3           23008                                                                                 */
/* DTE4                N3           23008                                                                                 */
/* DTE5                N3           23008                                                                                 */
/* DTE6                N3           23008                                                                                 */
/*                                                                                                                        */
/*                                                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

 /**************************************************************************************************************************/
 /*                                                                                                                        */
 /* 65 OUTPUT TABLES                                                                                                       */
 /*                                                                                                                        */
 /* A1JYN TABLE                                                                                                            */
 /*                                                                                                                        */
 /* Middle Observation(507 ) of table = a1jyn - Total Obs 1015 03MAY2023:15:41:17                                           */
 /*                                                                                                                        */
 /*  -- NUMERIC --                                                                                                         */
 /* PRIKEY              N8        10709706                                                                                 */
 /* GRP                 N8         1529900                                                                                 */
 /* DTE1                N3           23008                                                                                 */
 /* DTE2                N3           23008                                                                                 */
 /* DTE3                N3           23008                                                                                 */
 /* DTE4                N3           23008                                                                                 */
 /* DTE5                N3           23008                                                                                 */
 /* DTE6                N3           23008                                                                                 */
 /*                                                                                                                        */
 /* FROM SMALL 20 MILLON OBS TABLE                                                                                         */
 /*                                                                                                                        */
 /* DATES1              N3           23132                                                                                 */
 /* DATES2              N3           23132                                                                                 */
 /* DATES3              N3           23132                                                                                 */
 /* ....                                                                                                                   */
 /* DATES348            N3           23132                                                                                 */
 /* DATES349            N3           23132                                                                                 */
 /* DATES350            N3           23132                                                                                 */
 /*                                                                                                                        */
 /* ..... 63 other tables                                                                                                  */
 /*                                                                                                                        */
 /* A65JYN TABLE                                                                                                           */
 /*                                                                                                                        */
 /* Middle Observation(493 ) of table = a65jyn - Total Obs 986 03MAY2023:15:44:28                                          */
 /*                                                                                                                        */
 /*  -- NUMERIC --                                                                                                         */
 /* PRIKEY              N8        10709706                                                                                 */
 /* GRP                 N8         1529900                                                                                 */
 /* DTE1                N3           23008                                                                                 */
 /* DTE2                N3           23008                                                                                 */
 /* DTE3                N3           23008                                                                                 */
 /* DTE4                N3           23008                                                                                 */
 /* DTE5                N3           23008                                                                                 */
 /* DTE6                N3           23008                                                                                 */
 /*                                                                                                                        */
 /* FROM SMALL 20 MILLON OBS TABLE                                                                                         */
 /*                                                                                                                        */
 /* DATES1              N3           23132                                                                                 */
 /* DATES2              N3           23132                                                                                 */
 /* DATES3              N3           23132                                                                                 */
 /* ....                                                                                                                   */
 /* DATES348            N3           23132                                                                                 */
 /* DATES349            N3           23132                                                                                 */
 /* DATES350            N3           23132                                                                                 */
 /*                                                                                                                        */
 /*                                                                                                                        */
 /**************************************************************************************************************************/


%do_over(_seq,phrase=%str(
proc sql;
  create
     table a?Jyn as
  select
     "a?" as tbl
    ,a?.*
    ,big.*
  from
     sd1.havBig as big, a? as a?
  where
     big.priKey = a?.prikey
;quit;
));
run;quit;

/*---- real time           11.71 seconds                           ----*/


/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
