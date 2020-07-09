set language english;

insert into [DataBase].[dbo].[ПризнакиРаботыАлгоритмов]
select
	Пересечение.Минута,
	Пересечение.Алгоритм,
	(case when ВремяРаботыАлгоритмов.Алгоритм is not null then 1 else 0 end) РаботаАлгоритма
	from (select
			Время.[time] Минута,
			Алгоритм.Алгоритм
			from [DataBase].[dbo].[time] Время with (nolock)
			cross join (select distinct Алгоритм from [DataBase].[dbo].[ВремяРаботыАлгоритма] with (nolock)) Алгоритм) Пересечение
	left join [DataBase].[dbo].[ВремяРаботыАлгоритма] ВремяРаботыАлгоритмов with (nolock) 
	on Пересечение.Алгоритм = ВремяРаботыАлгоритмов.Алгоритм
		and Пересечение.Минута >= ВремяРаботыАлгоритмов.ВремяВхода
		and Пересечение.Минута <= ВремяРаботыАлгоритмов.ВремяВыхода
	where (case when ВремяРаботыАлгоритмов.Алгоритм is not null then 1 else 0 end) = 1
	order by
		Пересечение.Минута,
		Пересечение.Алгоритм