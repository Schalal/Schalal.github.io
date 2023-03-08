-- 计算工作日平均工作时长
drop table if exists beijing_custom_work_time_all;
create table beijing_custom_work_time_all as
select a.uid,
    a.date,
    pmod(datediff(to_date(a.stime), '2012-01-01'), 7) as weeknum,
    sum(
        least(
            cast(61200 as bigint),
            unix_timestamp(a.etime) - unix_timestamp(cast(a.etime as date))
        ) - greatest(
            cast(28800 as bigint),
            unix_timestamp(a.stime) - unix_timestamp(cast(a.stime as date))
        )
    ) / 3600 dwell_ss
from stay_month a left semi
    join demo_beijing_chaoyang_poi_202105_1 b on a.uid = b.uid
where a.province in ('011')
    and a.city in ('V0110000')
    and floor(a.date / 100) in (202105)
    and a.ptype = 2
    and (
        hour(a.stime) between 8 and 16
        or hour(a.etime) between 8 and 16
        or (
            hour(a.stime) < 8
            and hour(a.etime) > 16
        )
    )
group by a.uid,
    pmod(datediff(to_date(a.stime), '2012-01-01'), 7),
    a.date;
select weeknum,
    dwell_ss
from beijing_custom_work_time_all
limit 500;
--
drop table if exists beijing_custom_work_time;
create table beijing_custom_work_time as
select uid,
    floor(date / 100) date,
    sum(
        case
            when weeknum not in (0, 6) then dwell_ss
        end
    ) / sum(
        case
            when weeknum not in (0, 6) then 1
        end
    ) weekday_avg_time
from beijing_custom_work_time_all
group by uid,
    floor(date / 100);
select weekday_avg_time
from beijing_custom_work_time
limit 500;
select avg(weekday_avg_time)
from beijing_custom_work_time;
select avg(weekday_avg_time) avg_work_time
from beijing_custom_work_time;
select weekday_avg_time
from beijing_custom_work_time
limit 500;
create table demo_3_test as
select floor(date / 100) as date,
    province,
    uid,
    sum(
        case
            when weeknum not in(0, 6) then dwell_ss
        end
    ) / sum(
        case
            when weeknum not in(0, 6) then 1
        end
    ) weekday_avg_time,
    sum(
        case
            when weeknum in(0, 6) then dwell_ss
        end
    ) / sum(
        case
            when weeknum in(0, 6) then 1
        end
    ) weekend_avg_time
from (
        select a.uid,
            a.date,
            a.province,
            pmod(datediff(to_date(a.stime), '2012-01-01'), 7) as weeknum,
            sum(
                least(
                    cast(61200 as bigint),
                    unix_timestamp(a.etime) - unix_timestamp(cast(a.etime as date))
                ) - greatest(
                    cast(28800 as bigint),
                    unix_timestamp(a.stime) - unix_timestamp(cast(a.stime as date))
                )
            ) dwell_ss
        from stay_month a left semi
            join demo_2_test b on a.uid = b.uid
            and b.province = a.province
            and floor(a.date / 100) = floor(b.date / 100)
        where a.province in ('011')
            and a.city in ('V0110000')
            and floor(a.date / 100) in (202010)
            and a.ptype = 1
            and (
                hour(a.stime) between 8 and 16
                or hour(a.etime) between 8 and 16
                or (
                    hour(a.stime) < 8
                    and hour(a.etime) > 16
                )
            )
        group by a.uid,
            a.date,
            a.province,
            pmod(datediff(to_date(a.stime), '2012-01-01'), 7)
    ) p
group by floor(date / 100),
    province,
    uid;
    