import sys
import itertools


regions = {
	"TR":[
		(-3000.0,3000.0),
		(-1137.0,3000.0),
		(-1135.0,2720.0),
		(-932.0,2304.0),
		(-723.0,1954.0),
		(-621.0,1658.0),
		(-523.0,1256.0),
		(-469.0,1095.0),
		(-672.0,560.0),
		(-1032.0,647.0),
		(-1245.0,1132.0),
		(-1314.0,1538.0),
		(-1882.0,1723.0),
		(-2043.0,2068.0),
		(-3000.0,2070.0),
		(-3000.0,3000.0)
	],

	"SF":[
		(-2742.0,1517.0),
		(-1948.0,1517.0),
		(-1849.0,1552.0),
		(-1722.0,1551.0),
		(-1490.0,1304.0),
		(-1413.0,1106.0),
		(-1419.0,821.0),
		(-1481.0,658.0),
		(-1213.0,520.0),
		(-1077.0,508.0),
		(-991.0,501.0),
		(-991.0,369.0),
		(-1159.0,114.0),
		(-1067.0,-227.0),
		(-1142.0,-485.0),
		(-1210.0,-599.0),
		(-1223.0,-701.0),
		(-1636.0,-718.0),
		(-1702.0,-670.0),
		(-1772.0,-838.0),
		(-1873.0,-1138.0),
		(-2052.0,-1133.0),
		(-2193.0,-1061.0),
		(-2535.0,-860.0),
		(-2847.0,-1031.0),
		(-3000.0,-1026.0),
		(-3000.0,1216.0),
		(-2867.0,1357.0),
		(-2742.0,1517.0)
	],

	"FC":[
		(-1067.0,-227.0),
		(-914.0,-355.0),
		(-466.0,-332.0),
		(-278.0,-361.0),
		(-168.0,-801.0),
		(-95.0,-905.0),
		(97.0,-916.0),
		(46.0,-1106.0),
		(102.0,-1173.0),
		(35.0,-1274.0),
		(52.0,-1533.0),
		(57.0,-1597.0),
		(-170.0,-1699.0),
		(-127.0,-2118.0),
		(115.0,-2479.0),
		(115.0,-3000.0),
		(-3000.0,-3000.0),
		(-3000.0,-1026.0),
		(-2847.0,-1031.0),
		(-2535.0,-860.0),
		(-2193.0,-1061.0),
		(-2052.0,-1133.0),
		(-1873.0,-1138.0),
		(-1772.0,-838.0),
		(-1702.0,-670.0),
		(-1636.0,-718.0),
		(-1223.0,-701.0),
		(-1210.0,-599.0),
		(-1142.0,-485.0),
		(-1067.0,-227.0)
	],

	"LS":[
		(57.0,-1597.0),
		(57.0,-2019.0),
		(379.0,-2149.0),
		(864.0,-2156.0),
		(947.0,-2363.0),
		(1166.0,-2553.0),
		(1257.0,-2802.0),
		(2883.0,-2802.0),
		(2883.0,-2304.0),
		(3000.0,-2084.0),
		(3000.0,-1000.0),
		(2685.0,-1029.0),
		(2610.0,-920.0),
		(2306.0,-951.0),
		(2032.0,-940.0),
		(1721.0,-766.0),
		(1515.0,-575.0),
		(1306.0,-552.0),
		(1017.0,-628.0),
		(886.0,-632.0),
		(768.0,-754.0),
		(645.0,-882.0),
		(510.0,-887.0),
		(299.0,-1027.0),
		(102.0,-1173.0),
		(35.0,-1274.0),
		(52.0,-1533.0),
		(57.0,-1597.0)
	],

	"RC":[
		(102.0,-1173.0),
		(46.0,-1106.0),
		(97.0,-916.0),
		(-95.0,-905.0),
		(-168.0,-801.0),
		(-278.0,-361.0),
		(-466.0,-332.0),
		(-914.0,-355.0),
		(-1067.0,-227.0),
		(-979.0,77.0),
		(-672.0,345.0),
		(-95.0,313.0),
		(248.0,243.0),
		(604.0,449.0),
		(1004.0,586.0),
		(1112.0,628.0),
		(1437.0,551.0),
		(1817.0,486.0),
		(2026.0,476.0),
		(3000.0,465.0),
		(3000.0,-1000.0),
		(2685.0,-1029.0),
		(2610.0,-920.0),
		(2306.0,-951.0),
		(2032.0,-940.0),
		(1721.0,-766.0),
		(1515.0,-575.0),
		(1306.0,-552.0),
		(1017.0,-628.0),
		(886.0,-632.0),
		(645.0,-882.0),
		(510.0,-887.0),
		(299.0,-1027.0),
		(102.0,-1173.0)
	],

	"LV":[
		(3000.0,465.0),
		(3000.0,3000.0),
		(1046.0,3000.0),
		(919.0,2759.0),
		(898.0,2443.0),
		(862.0,2070.0),
		(849.0,1843.0),
		(895.0,1598.0),
		(945.0,1189.0),
		(962.0,956.0),
		(964.0,788.0),
		(961.0,683.0),
		(1004.0,586.0),
		(1112.0,628.0),
		(1437.0,551.0),
		(1817.0,486.0),
		(2026.0,476.0),
		(3000.0,465.0)
	],

	"BC":[
		(961.0,683.0),
		(811.0,583.0),
		(409.0,555.0),
		(-152.0,428.0),
		(-672.0,560.0),
		(-469.0,1095.0),
		(-523.0,1256.0),
		(-621.0,1658.0),
		(-723.0,1954.0),
		(-932.0,2304.0),
		(-1135.0,2720.0),
		(-1137.0,3000.0),
		(1046.0,3000.0),
		(919.0,2759.0),
		(898.0,2443.0),
		(862.0,2070.0),
		(849.0,1843.0),
		(895.0,1598.0),
		(945.0,1189.0),
		(962.0,956.0),
		(964.0,788.0),
		(961.0,683.0)
	],


	#
	#	SAN FIERRO
	#


	"SF_Bayfront":[
		(-2867.0,1357.0),
		(-2788.0,1276.0),
		(-2657.0,1281.0),
		(-2543.0,1364.0),
		(-2346.0,1368.0),
		(-2285.0,1327.0),
		(-2092.0,1317.0),
		(-2031.0,1299.0),
		(-1906.0,1315.0),
		(-1814.0,1372.0),
		(-1724.0,1322.0),
		(-1668.0,1265.0),
		(-1601.0,1187.0),
		(-1593.0,1028.0),
		(-1544.0,947.0),
		(-1550.0,767.0),
		(-1481.0,658.0),
		(-1419.0,821.0),
		(-1413.0,1106.0),
		(-1490.0,1304.0),
		(-1722.0,1551.0),
		(-1849.0,1552.0),
		(-1948.0,1517.0),
		(-2742.0,1517.0),
		(-2867.0,1357.0)
	],

	"SF_Housing2":[
		(-2788.0,1276.0),
		(-2657.0,1281.0),
		(-2543.0,1364.0),
		(-2346.0,1368.0),
		(-2285.0,1327.0),
		(-2092.0,1317.0),
		(-2136.0,1272.0),
		(-2261.0,1263.0),
		(-2265.0,1177.0),
		(-2310.0,1166.0),
		(-2308.0,1101.0),
		(-2308.0,1101.0),
		(-2310.0,959.0),
		(-2389.0,959.0),
		(-2389.0,908.0),
		(-2527.0,908.0),
		(-2527.0,565.0),
		(-2517.0,554.0),
		(-2518.0,481.0),
		(-2543.0,458.0),
		(-2699.0,461.0),
		(-2702.0,503.0),
		(-2743.0,554.0),
		(-2861.0,588.0),
		(-2932.0,697.0),
		(-2925.0,915.0),
		(-2961.0,1203.0),
		(-2812.0,1300.0),
		(-2788.0,1276.0)
	],

	"SF_Housing1":[
		(-2861.0,588.0),
		(-2743.0,554.0),
		(-2702.0,503.0),
		(-2699.0,461.0),
		(-2543.0,458.0),
		(-2562.0,413.0),
		(-2568.0,351.0),
		(-2568.0,336.0),
		(-2547.0,334.0),
		(-2549.0,299.0),
		(-2516.0,292.0),
		(-2517.0,250.0),
		(-2406.0,250.0),
		(-2261.0,261.0),
		(-2261.0,104.0),
		(-2266.0,-70.0),
		(-2267.0,-192.0),
		(-2396.0,-196.0),
		(-2448.0,-220.0),
		(-2960.0,-220.0),
		(-2950.0,135.0),
		(-2970.0,371.0),
		(-3000.0,455.0),
		(-3000.0,490.0),
		(-2947.0,547.0),
		(-2861.0,588.0)
	],

	"SF_City1":[
		(-2517.0,554.0),
		(-2518.0,481.0),
		(-2543.0,458.0),
		(-2562.0,413.0),
		(-2568.0,351.0),
		(-2568.0,336.0),
		(-2547.0,334.0),
		(-2549.0,299.0),
		(-2516.0,292.0),
		(-2517.0,250.0),
		(-2406.0,250.0),
		(-2261.0,261.0),
		(-2260.0,320.0),
		(-2147.0,320.0),
		(-2144.0,505.0),
		(-2143.0,732.0),
		(-2143.0,1177.0),
		(-2101.0,1179.0),
		(-2108.0,1222.0),
		(-2136.0,1272.0),
		(-2261.0,1263.0),
		(-2265.0,1177.0),
		(-2310.0,1166.0),
		(-2308.0,1101.0),
		(-2310.0,959.0),
		(-2389.0,959.0),
		(-2389.0,908.0),
		(-2527.0,908.0),
		(-2527.0,565.0),
		(-2517.0,554.0)
	],

	"SF_City2":[
		(-2147.0,320.0),
		(-2005.0,320.0),
		(-2005.0,399.0),
		(-1893.0,404.0),
		(-1831.0,480.0),
		(-1795.0,508.0),
		(-1721.0,581.0),
		(-1643.0,633.0),
		(-1542.0,640.0),
		(-1481.0,658.0),
		(-1550.0,767.0),
		(-1544.0,947.0),
		(-1593.0,1028.0),
		(-1601.0,1187.0),
		(-1668.0,1265.0),
		(-1724.0,1322.0),
		(-1814.0,1372.0),
		(-1906.0,1315.0),
		(-2031.0,1299.0),
		(-2092.0,1317.0),
		(-2136.0,1272.0),
		(-2108.0,1222.0),
		(-2101.0,1179.0),
		(-2143.0,1177.0),
		(-2143.0,732.0),
		(-2144.0,505.0),
		(-2147.0,320.0)
	],

	"SF_Industrial":[
		(-1481.0,658.0),
		(-1517.0,484.0),
		(-1548.0,483.0),
		(-1606.0,399.0),
		(-1690.0,318.0),
		(-1734.0,264.0),
		(-1634.0,220.0),
		(-1412.0,162.0),
		(-1593.0,-44.0),
		(-1734.0,-184.0),
		(-1757.0,-237.0),
		(-1972.0,-237.0),
		(-2007.0,-235.0),
		(-2006.0,-290.0),
		(-2206.0,-290.0),
		(-2206.0,-191.0),
		(-2267.0,-192.0),
		(-2266.0,-70.0),
		(-2261.0,104.0),
		(-2261.0,261.0),
		(-2260.0,320.0),
		(-2147.0,320.0),
		(-2005.0,320.0),
		(-2005.0,399.0),
		(-1893.0,404.0),
		(-1831.0,480.0),
		(-1795.0,508.0),
		(-1721.0,581.0),
		(-1643.0,633.0),
		(-1542.0,640.0),
		(-1481.0,658.0)
	],

	"SF_Naval":[
		(-1481.0,658.0),
		(-1213.0,520.0),
		(-1213.0,371.0),
		(-1412.0,162.0),
		(-1634.0,220.0),
		(-1734.0,264.0),
		(-1690.0,318.0),
		(-1606.0,399.0),
		(-1548.0,483.0),
		(-1517.0,484.0),
		(-1481.0,658.0)
	],

	"SF_Airport":[
		(-1757.0,-237.0),
		(-1757.0,-531.0),
		(-1739.0,-564.0),
		(-1737.0,-597.0),
		(-1702.0,-670.0),
		(-1636.0,-718.0),
		(-1223.0,-701.0),
		(-1210.0,-599.0),
		(-1142.0,-485.0),
		(-1067.0,-227.0),
		(-1159.0,114.0),
		(-991.0,369.0),
		(-991.0,501.0),
		(-1077.0,508.0),
		(-1213.0,371.0),
		(-1412.0,162.0),
		(-1593.0,-44.0),
		(-1734.0,-184.0),
		(-1757.0,-237.0)
	],

	"SF_MontFost":[
		(-2960.0,-220.0),
		(-3000.0,-220.0),
		(-3000.0,-1026.0),
		(-2847.0,-1031.0),
		(-2535.0,-860.0),
		(-2193.0,-1061.0),
		(-2052.0,-1133.0),
		(-1873.0,-1138.0),
		(-1772.0,-838.0),
		(-1702.0,-670.0),
		(-1737.0,-597.0),
		(-1739.0,-564.0),
		(-1757.0,-531.0),
		(-1757.0,-237.0),
		(-1972.0,-237.0),
		(-2007.0,-235.0),
		(-2006.0,-290.0),
		(-2206.0,-290.0),
		(-2206.0,-191.0),
		(-2267.0,-192.0),
		(-2396.0,-196.0),
		(-2448.0,-220.0),
		(-2960.0,-220.0)
	],


	#
	#	LOS SANTOS
	#


	"LS_City3":[
		(57.0,-1597.0),
		(52.0,-1533.0),
		(96.0,-1537.0),
		(146.0,-1567.0),
		(238.0,-1671.0),
		(322.0,-1707.0),
		(327.0,-1642.0),
		(327.0,-1584.0),
		(363.0,-1515.0),
		(499.0,-1424.0),
		(633.0,-1401.0),
		(1348.0,-1400.0),
		(1340.0,-1480.0),
		(1306.0,-1554.0),
		(1304.0,-1851.0),
		(1057.0,-1855.0),
		(1041.0,-2075.0),
		(864.0,-2156.0),
		(379.0,-2149.0),
		(57.0,-2019.0),
		(57.0,-1597.0)
	],

	"LS_CIty2":[
		(146.0,-1567.0),
		(241.0,-1438.0),
		(376.0,-1365.0),
		(512.0,-1272.0),
		(613.0,-1217.0),
		(674.0,-1181.0),
		(744.0,-1064.0),
		(794.0,-1049.0),
		(838.0,-1034.0),
		(890.0,-988.0),
		(962.0,-969.0),
		(1160.0,-949.0),
		(1301.0,-926.0),
		(1370.0,-938.0),
		(1362.0,-1036.0),
		(1349.0,-1141.0),
		(1348.0,-1400.0),
		(633.0,-1401.0),
		(499.0,-1424.0),
		(363.0,-1515.0),
		(327.0,-1584.0),
		(327.0,-1642.0),
		(322.0,-1707.0),
		(238.0,-1671.0),
		(146.0,-1567.0)
	],

	"LS_Housing4":[
		(1370.0,-938.0),
		(1448.0,-949.0),
		(1462.0,-932.0),
		(1546.0,-903.0),
		(1574.0,-846.0),
		(1560.0,-742.0),
		(1526.0,-635.0),
		(1515.0,-575.0),
		(1306.0,-552.0),
		(1017.0,-628.0),
		(886.0,-632.0),
		(768.0,-754.0),
		(645.0,-882.0),
		(510.0,-887.0),
		(299.0,-1027.0),
		(102.0,-1173.0),
		(35.0,-1274.0),
		(52.0,-1533.0),
		(96.0,-1537.0),
		(146.0,-1567.0),
		(241.0,-1438.0),
		(376.0,-1365.0),
		(512.0,-1272.0),
		(613.0,-1217.0),
		(674.0,-1181.0),
		(744.0,-1064.0),
		(794.0,-1049.0),
		(838.0,-1034.0),
		(890.0,-988.0),
		(962.0,-969.0),
		(1160.0,-949.0),
		(1301.0,-926.0),
		(1370.0,-938.0)
	],

	"LS_VerdantBluffs":[
		(1166.0,-2553.0),
		(1337.0,-2456.0),
		(1354.0,-2175.0),
		(1448.0,-2123.0),
		(1565.0,-2115.0),
		(1651.0,-2041.0),
		(1658.0,-1949.0),
		(1634.0,-1872.0),
		(1378.0,-1872.0),
		(1304.0,-1851.0),
		(1057.0,-1855.0),
		(1041.0,-2075.0),
		(864.0,-2156.0),
		(947.0,-2363.0),
		(1166.0,-2553.0)
	],

	"LS_Airport":[
		(1565.0,-2115.0),
		(1657.0,-2167.0),
		(1822.0,-2166.0),
		(1962.0,-2167.0),
		(2074.0,-2169.0),
		(2142.0,-2223.0),
		(2105.0,-2265.0),
		(2102.0,-2322.0),
		(2142.0,-2331.0),
		(2192.0,-2373.0),
		(2171.0,-2421.0),
		(2165.0,-2595.0),
		(2105.0,-2667.0),
		(2057.0,-2698.0),
		(1441.0,-2695.0),
		(1352.0,-2624.0),
		(1337.0,-2456.0),
		(1354.0,-2175.0),
		(1448.0,-2123.0),
		(1565.0,-2115.0)
	],

	"LS_Industrial":[
		(1658.0,-1949.0),
		(1813.0,-1955.0),
		(1822.0,-1930.0),
		(1962.0,-1931.0),
		(1965.0,-1849.0),
		(2218.0,-1852.0),
		(2413.0,-1854.0),
		(2413.0,-2049.0),
		(2829.0,-2049.0),
		(2800.0,-2131.0),
		(2713.0,-2163.0),
		(2412.0,-2172.0),
		(2192.0,-2373.0),
		(2142.0,-2331.0),
		(2102.0,-2322.0),
		(2105.0,-2265.0),
		(2142.0,-2223.0),
		(2074.0,-2169.0),
		(1962.0,-2167.0),
		(1822.0,-2166.0),
		(1657.0,-2167.0),
		(1565.0,-2115.0),
		(1651.0,-2041.0),
		(1658.0,-1949.0)
	],

	"LS_Housing2":[
		(1634.0,-1872.0),
		(1681.0,-1861.0),
		(1690.0,-1815.0),
		(1822.0,-1832.0),
		(1822.0,-1585.0),
		(1845.0,-1507.0),
		(2064.0,-1510.0),
		(2112.0,-1524.0),
		(2208.0,-1567.0),
		(2289.0,-1599.0),
		(2340.0,-1609.0),
		(2584.0,-1614.0),
		(2586.0,-2049.0),
		(2413.0,-2049.0),
		(2413.0,-1854.0),
		(2218.0,-1852.0),
		(1965.0,-1849.0),
		(1962.0,-1931.0),
		(1822.0,-1930.0),
		(1813.0,-1955.0),
		(1658.0,-1949.0),
		(1634.0,-1872.0)
	],

	"LS_Seafront":[
		(2584.0,-1614.0),
		(2607.0,-1445.0),
		(2642.0,-1444.0),
		(2640.0,-1153.0),
		(2641.0,-1047.0),
		(2685.0,-1029.0),
		(3000.0,-1000.0),
		(3000.0,-2084.0),
		(2829.0,-2049.0),
		(2586.0,-2049.0),
		(2584.0,-1614.0)
	],

	"LS_Housing1":[
		(1845.0,-1507.0),
		(1844.0,-1183.0),
		(1864.0,-1179.0),
		(1868.0,-1058.0),
		(1889.0,-1042.0),
		(1982.0,-1052.0),
		(2071.0,-1090.0),
		(2137.0,-1114.0),
		(2184.0,-1121.0),
		(2288.0,-1150.0),
		(2328.0,-1153.0),
		(2640.0,-1153.0),
		(2642.0,-1444.0),
		(2607.0,-1445.0),
		(2584.0,-1614.0),
		(2340.0,-1609.0),
		(2289.0,-1599.0),
		(2208.0,-1567.0),
		(2112.0,-1524.0),
		(2064.0,-1510.0),
		(1845.0,-1507.0)
	],

	"LS_Housing3":[
		(1982.0,-1052.0),
		(1989.0,-1014.0),
		(1975.0,-980.0),
		(2032.0,-940.0),
		(2306.0,-951.0),
		(2610.0,-920.0),
		(2685.0,-1029.0),
		(2641.0,-1047.0),
		(2640.0,-1153.0),
		(2328.0,-1153.0),
		(2288.0,-1150.0),
		(2184.0,-1121.0),
		(2137.0,-1114.0),
		(2071.0,-1090.0),
		(1982.0,-1052.0)
	],

	"LS_City1":[
		(1975.0,-980.0),
		(1871.0,-997.0),
		(1813.0,-1006.0),
		(1448.0,-949.0),
		(1370.0,-938.0),
		(1362.0,-1036.0),
		(1349.0,-1141.0),
		(1348.0,-1400.0),
		(1340.0,-1480.0),
		(1306.0,-1554.0),
		(1304.0,-1851.0),
		(1378.0,-1872.0),
		(1634.0,-1872.0),
		(1681.0,-1861.0),
		(1690.0,-1815.0),
		(1822.0,-1832.0),
		(1822.0,-1585.0),
		(1845.0,-1507.0),
		(1844.0,-1183.0),
		(1864.0,-1179.0),
		(1868.0,-1058.0),
		(1889.0,-1042.0),
		(1982.0,-1052.0),
		(1989.0,-1014.0),
		(1975.0,-980.0)
	],

	"LS_Docks":[
		(2713.0,-2163.0),
		(2766.0,-2186.0),
		(2883.0,-2304.0),
		(2883.0,-2802.0),
		(2057.0,-2802.0),
		(2057.0,-2698.0),
		(2105.0,-2667.0),
		(2165.0,-2595.0),
		(2171.0,-2421.0),
		(2192.0,-2373.0),
		(2412.0,-2172.0),
		(2713.0,-2163.0)
	],


	#
	#	LAS VENTURAS
	#


	"LV_Housing3":[
		(1115.0,2867.0),
		(1416.0,2886.0),
		(1535.0,2886.0),
		(1921.0,2886.0),
		(2214.0,2860.0),
		(2462.0,2829.0),
		(2463.0,2753.0),
		(2388.0,2624.0),
		(2218.0,2608.0),
		(2027.0,2558.0),
		(1819.0,2496.0),
		(1644.0,2464.0),
		(1478.0,2461.0),
		(1384.0,2460.0),
		(1353.0,2504.0),
		(1244.0,2506.0),
		(1199.0,2574.0),
		(1195.0,2710.0),
		(1115.0,2720.0),
		(1115.0,2867.0)
	],

	"LV_KACC":[
		(2492.0,2862.0),
		(2756.0,2862.0),
		(2756.0,2667.0),
		(2704.0,2667.0),
		(2704.0,2617.0),
		(2569.0,2617.0),
		(2492.0,2689.0),
		(2492.0,2862.0)
	],

	"LV_City2":[
		(2388.0,2624.0),
		(2569.0,2617.0),
		(2704.0,2617.0),
		(2704.0,2667.0),
		(2756.0,2667.0),
		(2879.0,2667.0),
		(2926.0,2491.0),
		(2926.0,2279.0),
		(2841.0,1958.0),
		(2508.0,1952.0),
		(2508.0,1973.0),
		(2350.0,1973.0),
		(2350.0,2023.0),
		(2138.0,2023.0),
		(1929.0,2023.0),
		(1903.0,2041.0),
		(1832.0,2053.0),
		(1763.0,2173.0),
		(1798.0,2173.0),
		(1797.0,2272.0),
		(1819.0,2496.0),
		(2027.0,2558.0),
		(2218.0,2608.0),
		(2388.0,2624.0)
	],

	"LV_Housing1":[
		(1832.0,2053.0),
		(1799.0,2053.0),
		(1799.0,1714.0),
		(1707.0,1704.0),
		(1572.0,1704.0),
		(1558.0,1717.0),
		(1557.0,1864.0),
		(1337.0,1864.0),
		(1291.0,1911.0),
		(1217.0,1911.0),
		(1217.0,2164.0),
		(1316.0,2281.0),
		(1360.0,2385.0),
		(1384.0,2460.0),
		(1478.0,2461.0),
		(1644.0,2464.0),
		(1758.0,2393.0),
		(1797.0,2272.0),
		(1798.0,2173.0),
		(1763.0,2173.0),
		(1832.0,2053.0)
	],

	"LV_Housing2":[
		(1217.0,2164.0),
		(1161.0,2348.0),
		(1116.0,2425.0),
		(1006.0,2464.0),
		(898.0,2443.0),
		(862.0,2070.0),
		(849.0,1843.0),
		(895.0,1598.0),
		(945.0,1189.0),
		(962.0,956.0),
		(964.0,788.0),
		(1035.0,775.0),
		(1157.0,897.0),
		(1217.0,1045.0),
		(1217.0,2164.0)
	],

	"LV_Airport":[
		(1337.0,1864.0),
		(1337.0,1803.0),
		(1313.0,1803.0),
		(1313.0,1670.0),
		(1258.0,1670.0),
		(1258.0,1212.0),
		(1297.0,1212.0),
		(1297.0,1203.0),
		(1457.0,1203.0),
		(1457.0,1143.0),
		(1636.0,1143.0),
		(1636.0,1283.0),
		(1797.0,1283.0),
		(1799.0,1714.0),
		(1707.0,1704.0),
		(1572.0,1704.0),
		(1558.0,1717.0),
		(1557.0,1864.0),
		(1337.0,1864.0)
	],

	"LV_Strip":[
		(2350.0,1973.0),
		(2350.0,1890.0),
		(2327.0,1773.0),
		(2327.0,1612.0),
		(2427.0,1612.0),
		(2427.0,1193.0),
		(2346.0,1193.0),
		(2346.0,973.0),
		(2287.0,973.0),
		(2287.0,842.0),
		(1797.0,843.0),
		(1797.0,1283.0),
		(1799.0,1714.0),
		(1799.0,2053.0),
		(1832.0,2053.0),
		(1903.0,2041.0),
		(1929.0,2023.0),
		(2138.0,2023.0),
		(2350.0,2023.0),
		(2350.0,1973.0)
	],

	"LV_City1":[
		(2841.0,1958.0),
		(2841.0,1772.0),
		(2908.0,1672.0),
		(2907.0,1575.0),
		(2878.0,1473.0),
		(2719.0,1473.0),
		(2719.0,1218.0),
		(2710.0,1046.0),
		(2643.0,936.0),
		(2546.0,868.0),
		(2465.0,842.0),
		(2287.0,842.0),
		(2287.0,973.0),
		(2346.0,973.0),
		(2346.0,1193.0),
		(2427.0,1193.0),
		(2427.0,1612.0),
		(2327.0,1612.0),
		(2327.0,1773.0),
		(2350.0,1890.0),
		(2350.0,1973.0),
		(2508.0,1973.0),
		(2508.0,1952.0),
		(2841.0,1958.0)
	],

	"LV_Industrial2":[
		(2878.0,1473.0),
		(2878.0,1165.0),
		(2898.0,1026.0),
		(2898.0,830.0),
		(2735.0,768.0),
		(2696.0,685.0),
		(2470.0,647.0),
		(2374.0,510.0),
		(2263.0,508.0),
		(2137.0,620.0),
		(1822.0,620.0),
		(1780.0,660.0),
		(1797.0,843.0),
		(2287.0,842.0),
		(2465.0,842.0),
		(2546.0,868.0),
		(2643.0,936.0),
		(2710.0,1046.0),
		(2719.0,1218.0),
		(2719.0,1473.0),
		(2878.0,1473.0)
	],

	"LV_Industrial1":[
		(1780.0,660.0),
		(1642.0,566.0),
		(1613.0,566.0),
		(1580.0,593.0),
		(1561.0,639.0),
		(1336.0,641.0),
		(1336.0,806.0),
		(1377.0,908.0),
		(1376.0,1010.0),
		(1344.0,1011.0),
		(1344.0,1061.0),
		(1299.0,1062.0),
		(1286.0,1078.0),
		(1276.0,1103.0),
		(1276.0,1184.0),
		(1297.0,1203.0),
		(1457.0,1203.0),
		(1457.0,1143.0),
		(1636.0,1143.0),
		(1636.0,1283.0),
		(1797.0,1283.0),
		(1797.0,843.0),
		(1780.0,660.0)
	],


	#
	#	TIERRA ROBADA
	#


	"TR_Bayside":[
		(-2647.0,2231.0),
		(-2581.0,2227.0),
		(-2497.0,2201.0),
		(-2366.0,2205.0),
		(-2282.0,2220.0),
		(-2207.0,2263.0),
		(-2183.0,2333.0),
		(-2170.0,2418.0),
		(-2240.0,2483.0),
		(-2315.0,2546.0),
		(-2528.0,2546.0),
		(-2621.0,2458.0),
		(-2643.0,2407.0),
		(-2647.0,2231.0)
	],

	"TR_Quebrados":[
		(-1267.0,2747.0),
		(-1233.0,2701.0),
		(-1226.0,2670.0),
		(-1335.0,2631.0),
		(-1372.0,2588.0),
		(-1485.0,2500.0),
		(-1544.0,2500.0),
		(-1614.0,2503.0),
		(-1658.0,2455.0),
		(-1683.0,2477.0),
		(-1677.0,2558.0),
		(-1681.0,2610.0),
		(-1623.0,2711.0),
		(-1566.0,2723.0),
		(-1437.0,2711.0),
		(-1384.0,2679.0),
		(-1267.0,2747.0)
	],

	"TR_Barrancas":[
		(-854.0,1629.0),
		(-780.0,1657.0),
		(-727.0,1660.0),
		(-700.0,1616.0),
		(-643.0,1575.0),
		(-620.0,1519.0),
		(-625.0,1429.0),
		(-704.0,1416.0),
		(-769.0,1409.0),
		(-852.0,1402.0),
		(-920.0,1498.0),
		(-920.0,1576.0),
		(-854.0,1629.0)
	],


	#
	#	BONE COUNTY
	#


	"BC_Carson":[
		(-447.0,1159.0),
		(-391.0,1219.0),
		(-270.0,1255.0),
		(-85.0,1280.0),
		(56.0,1279.0),
		(205.0,1233.0),
		(196.0,1137.0),
		(206.0,1060.0),
		(100.0,1015.0),
		(78.0,896.0),
		(-16.0,889.0),
		(-123.0,833.0),
		(-173.0,867.0),
		(-182.0,946.0),
		(-241.0,956.0),
		(-304.0,971.0),
		(-343.0,1022.0),
		(-386.0,1093.0),
		(-447.0,1159.0)
	],

	"BC_Ear":[
		(-350.0,1646.0),
		(-239.0,1549.0),
		(-275.0,1500.0),
		(-405.0,1502.0),
		(-406.0,1598.0),
		(-350.0,1646.0)
	],

	"BC_Octane":[
		(100.0,1490.0),
		(301.0,1490.0),
		(415.0,1585.0),
		(556.0,1575.0),
		(621.0,1556.0),
		(663.0,1478.0),
		(648.0,1334.0),
		(568.0,1291.0),
		(434.0,1253.0),
		(339.0,1276.0),
		(294.0,1328.0),
		(100.0,1328.0),
		(100.0,1490.0)
	],

	"BC_Hunter":[
		(401.0,972.0),
		(510.0,1023.0),
		(653.0,1042.0),
		(768.0,988.0),
		(820.0,906.0),
		(839.0,838.0),
		(801.0,795.0),
		(765.0,737.0),
		(662.0,701.0),
		(544.0,724.0),
		(433.0,791.0),
		(341.0,817.0),
		(302.0,876.0),
		(300.0,941.0),
		(401.0,972.0)
	],

	"BC_Area69":[
		(393.0,2086.0),
		(393.0,1885.0),
		(359.0,1872.0),
		(359.0,1805.0),
		(323.0,1779.0),
		(273.0,1779.0),
		(273.0,1800.0),
		(92.0,1800.0),
		(92.0,1946.0),
		(184.0,1946.0),
		(184.0,2058.0),
		(167.0,2076.0),
		(169.0,2096.0),
		(189.0,2105.0),
		(208.0,2086.0),
		(393.0,2086.0)
	],

	"BC_Verdant":[
		(435.0,2427.0),
		(363.0,2383.0),
		(75.0,2383.0),
		(52.0,2467.0),
		(-91.0,2467.0),
		(-91.0,2571.0),
		(68.0,2569.0),
		(114.0,2618.0),
		(173.0,2664.0),
		(234.0,2670.0),
		(287.0,2667.0),
		(394.0,2621.0),
		(448.0,2560.0),
		(448.0,2475.0),
		(435.0,2427.0)
	],

	"BC_Playasdas":[
		(-196.0,2588.0),
		(-243.0,2576.0),
		(-294.0,2576.0),
		(-392.0,2677.0),
		(-367.0,2713.0),
		(-311.0,2737.0),
		(-301.0,2772.0),
		(-269.0,2796.0),
		(-227.0,2826.0),
		(-179.0,2789.0),
		(-148.0,2767.0),
		(-137.0,2677.0),
		(-149.0,2619.0),
		(-196.0,2588.0)
	],

	"BC_Ocultado":[
		(-900.0,2777.0),
		(-745.0,2784.0),
		(-710.0,2746.0),
		(-713.0,2716.0),
		(-851.0,2715.0),
		(-901.0,2666.0),
		(-926.0,2635.0),
		(-957.0,2656.0),
		(-904.0,2713.0),
		(-900.0,2777.0)
	],

	"BC_East":[
		(795.0,2100.0),
		(805.0,1988.0),
		(802.0,1846.0),
		(805.0,1738.0),
		(822.0,1691.0),
		(822.0,1601.0),
		(775.0,1601.0),
		(570.0,1619.0),
		(513.0,1693.0),
		(620.0,1763.0),
		(648.0,1994.0),
		(675.0,2007.0),
		(728.0,2015.0),
		(729.0,2098.0),
		(795.0,2100.0)
	],

	"BC_Probe":[
		(-119.0,1388.0),
		(-26.0,1416.0),
		(50.0,1398.0),
		(49.0,1323.0),
		(-112.0,1324.0),
		(-119.0,1388.0)
	],

	"BC_Ghost":[
		(-356.0,2276.0),
		(-342.0,2223.0),
		(-373.0,2188.0),
		(-484.0,2162.0),
		(-503.0,2192.0),
		(-450.0,2262.0),
		(-356.0,2276.0)
	],


	#
	#	FLINT COUNTY
	#


	"FC_Chilliad":[
		(-2193.0,-1061.0),
		(-2056.0,-1274.0),
		(-1980.0,-1356.0),
		(-1931.0,-1438.0),
		(-1910.0,-1496.0),
		(-1908.0,-1631.0),
		(-1945.0,-1633.0),
		(-1982.0,-1724.0),
		(-2077.0,-1913.0),
		(-2125.0,-2021.0),
		(-2260.0,-2159.0),
		(-2342.0,-2216.0),
		(-2425.0,-2233.0),
		(-2522.0,-2147.0),
		(-2609.0,-2196.0),
		(-2650.0,-2190.0),
		(-2971.0,-1923.0),
		(-2988.0,-1702.0),
		(-3000.0,-1026.0),
		(-2847.0,-1031.0),
		(-2535.0,-860.0),
		(-2193.0,-1061.0)
	],

	"FC_Angel":[
		(-2202.0,-2223.0),
		(-2102.0,-2214.0),
		(-2054.0,-2257.0),
		(-2034.0,-2314.0),
		(-1932.0,-2424.0),
		(-1940.0,-2455.0),
		(-2000.0,-2542.0),
		(-2040.0,-2582.0),
		(-2074.0,-2589.0),
		(-2160.0,-2568.0),
		(-2235.0,-2590.0),
		(-2279.0,-2569.0),
		(-2261.0,-2486.0),
		(-2273.0,-2426.0),
		(-2222.0,-2354.0),
		(-2261.0,-2314.0),
		(-2202.0,-2223.0)
	],

	"FC_Scrapyard":[
		(-1910.0,-1496.0),
		(-1782.0,-1586.0),
		(-1747.0,-1656.0),
		(-1823.0,-1709.0),
		(-1847.0,-1723.0),
		(-1920.0,-1767.0),
		(-1946.0,-1767.0),
		(-1945.0,-1633.0),
		(-1908.0,-1631.0),
		(-1910.0,-1496.0)
	],

	"FC_Chem":[
		(-1130.0,-762.0),
		(-1000.0,-762.0),
		(-970.0,-722.0),
		(-970.0,-618.0),
		(-1001.0,-586.0),
		(-1130.0,-586.0),
		(-1130.0,-762.0)
	],

	"FC_FallenTree":[
		(-463.0,-464.0),
		(-463.0,-566.0),
		(-626.0,-566.0),
		(-626.0,-464.0),
		(-463.0,-464.0)
	],

	"FC_Beacon":[
		(-401.0,-1018.0),
		(-328.0,-1011.0),
		(-328.0,-1080.0),
		(-385.0,-1163.0),
		(-406.0,-1163.0),
		(-425.0,-1071.0),
		(-401.0,-1018.0)
	],

	"FC_FlintRange":[
		(-359.0,-1470.0),
		(-466.0,-1472.0),
		(-539.0,-1526.0),
		(-583.0,-1513.0),
		(-592.0,-1465.0),
		(-514.0,-1412.0),
		(-384.0,-1396.0),
		(-353.0,-1403.0),
		(-359.0,-1470.0)
	],

	"FC_Leafy":[
		(-1132.0,-1702.0),
		(-1132.0,-1599.0),
		(-1075.0,-1599.0),
		(-1013.0,-1613.0),
		(-975.0,-1668.0),
		(-975.0,-1734.0),
		(-1132.0,-1702.0)
	],

	"FC_Farm1":[
		(-1214.0,-907.0),
		(-998.0,-907.0),
		(-998.0,-1065.0),
		(-1016.0,-1221.0),
		(-1032.0,-1269.0),
		(-1129.0,-1258.0),
		(-1166.0,-1227.0),
		(-1212.0,-1177.0),
		(-1214.0,-1112.0),
		(-1214.0,-907.0)
	],

	"FC_East":[
		(-18.0,-1120.0),
		(-35.0,-1165.0),
		(-83.0,-1223.0),
		(-121.0,-1194.0),
		(-93.0,-1139.0),
		(-77.0,-1096.0),
		(-18.0,-1120.0)
	],

	"FC_Trailer1":[
		(-973.0,-484.0),
		(-895.0,-484.0),
		(-901.0,-554.0),
		(-972.0,-554.0),
		(-973.0,-484.0)
	],

	"FC_Trailer2":[
		(-77.0,-1525.0),
		(-37.0,-1556.0),
		(-55.0,-1588.0),
		(-86.0,-1614.0),
		(-121.0,-1574.0),
		(-77.0,-1525.0)
	],

	"FC_Farm2":[
		(-1474.0,-1442.0),
		(-1410.0,-1440.0),
		(-1396.0,-1539.0),
		(-1419.0,-1605.0),
		(-1470.0,-1603.0),
		(-1474.0,-1442.0)
	],


	#
	#	RED COUNTY
	#


	"RC_Logging":[
		(-717.0,-90.0),
		(-583.0,-36.0),
		(-416.0,-27.0),
		(-416.0,-204.0),
		(-591.0,-212.0),
		(-689.0,-179.0),
		(-776.0,-205.0),
		(-833.0,-199.0),
		(-851.0,-136.0),
		(-717.0,-90.0)
	],

	"RC_BlueAcres":[
		(-194.0,225.0),
		(-28.0,166.0),
		(82.0,96.0),
		(127.0,39.0),
		(117.0,-73.0),
		(118.0,-139.0),
		(77.0,-145.0),
		(76.0,-198.0),
		(20.0,-197.0),
		(-129.0,-179.0),
		(-300.0,-136.0),
		(-298.0,-70.0),
		(-236.0,135.0),
		(-194.0,225.0)
	],

	"RC_Blueberry":[
		(127.0,39.0),
		(200.0,46.0),
		(232.0,41.0),
		(279.0,48.0),
		(334.0,78.0),
		(363.0,68.0),
		(342.0,-10.0),
		(341.0,-53.0),
		(380.0,-54.0),
		(380.0,-155.0),
		(329.0,-263.0),
		(275.0,-318.0),
		(198.0,-318.0),
		(196.0,-293.0),
		(177.0,-283.0),
		(175.0,-217.0),
		(77.0,-219.0),
		(76.0,-198.0),
		(77.0,-145.0),
		(118.0,-139.0),
		(117.0,-73.0),
		(127.0,39.0)
	],

	"RC_Brewery":[
		(198.0,-318.0),
		(200.0,-350.0),
		(21.0,-349.0),
		(21.0,-401.0),
		(-81.0,-401.0),
		(-114.0,-388.0),
		(-196.0,-314.0),
		(-250.0,-250.0),
		(-253.0,-212.0),
		(-237.0,-173.0),
		(-121.0,-202.0),
		(17.0,-218.0),
		(77.0,-219.0),
		(175.0,-217.0),
		(177.0,-283.0),
		(196.0,-293.0),
		(198.0,-318.0)
	],

	"RC_Montgomery":[
		(1353.0,499.0),
		(1422.0,468.0),
		(1516.0,400.0),
		(1510.0,355.0),
		(1424.0,176.0),
		(1307.0,122.0),
		(1227.0,121.0),
		(1177.0,142.0),
		(1179.0,231.0),
		(1187.0,294.0),
		(1220.0,373.0),
		(1269.0,400.0),
		(1303.0,421.0),
		(1353.0,499.0)
	],

	"RC_Palmino":[
		(2552.0,153.0),
		(2574.0,105.0),
		(2574.0,-22.0),
		(2528.0,-54.0),
		(2456.0,-79.0),
		(2336.0,-149.0),
		(2230.0,-149.0),
		(2157.0,-131.0),
		(2090.0,-116.0),
		(2110.0,-13.0),
		(2177.0,120.0),
		(2214.0,196.0),
		(2302.0,206.0),
		(2387.0,206.0),
		(2552.0,153.0)
	],

	"RC_Dillimore":[
		(836.0,-474.0),
		(842.0,-525.0),
		(878.0,-575.0),
		(875.0,-613.0),
		(839.0,-650.0),
		(776.0,-650.0),
		(681.0,-657.0),
		(631.0,-649.0),
		(598.0,-619.0),
		(590.0,-530.0),
		(593.0,-478.0),
		(628.0,-438.0),
		(729.0,-436.0),
		(836.0,-474.0)
	],

	"RC_Trailer":[
		(815.0,402.0),
		(825.0,351.0),
		(795.0,251.0),
		(709.0,241.0),
		(683.0,287.0),
		(724.0,388.0),
		(815.0,402.0)
	],

	"RC_Farm1":[
		(1001.0,-277.0),
		(1127.0,-286.0),
		(1127.0,-377.0),
		(1001.0,-373.0),
		(1001.0,-277.0)
	],

	"RC_Farm2":[
		(1590.0,55.0),
		(1602.0,9.0),
		(1568.0,-43.0),
		(1540.0,-43.0),
		(1504.0,-2.0),
		(1503.0,30.0),
		(1590.0,55.0)
	],

	"RC_Farm3":[
		(1891.0,194.0),
		(1960.0,173.0),
		(1997.0,163.0),
		(1967.0,125.0),
		(1888.0,155.0),
		(1891.0,194.0)
	]
}

# http://geospatialpython.com/2011/08/point-in-polygon-2-on-line.html
def is_point_in_poly(x, y, poly):

	# check if point is a vertex
	if (x, y) in poly:
		return True

	# check if point is on a boundary
	for i in range(len(poly)):
		p1 = None
		p2 = None
		if i==0:
			p1 = poly[0]
			p2 = poly[1]
		else:
			p1 = poly[i-1]
			p2 = poly[i]
		if p1[1] == p2[1] and p1[1] == y and x > min(p1[0], p2[0]) and x < max(p1[0], p2[0]):
			return True

	n = len(poly)
	inside = False
	p1x, p1y = poly[0]

	for i in range(n + 1):
		p2x, p2y = poly[(i % n)]

		if y > min(p1y, p2y):
			if y <= max(p1y, p2y):
				if x <= max(p1x, p2x):

					if p1y != p2y:
						xinters = (y-p1y) * (p2x-p1x) / (p2y-p1y) + p1x

					if p1x == p2x or x <= xinters:
						inside = not inside

		p1x, p1y = p2x, p2y

	return inside


def is_point_in(x, y, name):

	return is_point_in_poly(x, y, regions[name])


def get_area(x, y):
	"""Calculates the signed area of an arbitrary polygon given its verticies
	http://stackoverflow.com/a/4682656/190597 (Joe Kington)
	http://softsurfer.com/Archive/algorithm_0101/algorithm_0101.htm#2D%20Polygons
	"""
	area = 0.0
	for i in range(-1, len(x) - 1):
		area += x[i] * (y[i + 1] - y[i - 1])
	return area / 2.0


def center(points):
	"""
	http://stackoverflow.com/a/14115494/190597 (mgamba)
	"""
	area = get_area(*zip(*points))
	result_x = 0
	result_y = 0
	N = len(points)
	points = itertools.cycle(points)
	x1, y1 = next(points)
	for i in range(N):
		x0, y0 = x1, y1
		x1, y1 = next(points)
		cross = (x0 * y1) - (x1 * y0)
		result_x += (x0 + x1) * cross
		result_y += (y0 + y1) * cross
	result_x /= (area * 6.0)
	result_y /= (area * 6.0)
	return (result_x, result_y)


if __name__ == '__main__':
	if len(sys.argv) != 4:
		print("Parameters: x, y, region name")

	else:
		x = float(sys.argv[1])
		y = float(sys.argv[2])
		n = sys.argv[3]
		print(is_point_in(x, y, n)) 
