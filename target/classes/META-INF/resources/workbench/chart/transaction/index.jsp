<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";

    /**
     * 需求：
     *      根据交易表中的不同阶段的数量进行统计，最终形成一个漏斗图（倒三角）
     *
     *      将统计出来的阶段的数量比较多的，往上边排列
     *      将统计出来的阶段的数量比较少的，往下边排列
     *
     *      sql：
     *          按照阶段进行分组
     *              select
     *                  stage, count(*)
     *              from
     *                  from tbl_tran
     *              group by
     *                  stage
     *
     * */


%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="ECharts/echarts.min.js"></script>
    <script src="jquery/jquery-1.11.1-min.js"></script>

    <script type="text/javascript">

        $(function () {

            //交易阶段柱状图
            // getTransactionBasicBarCharts();

            //交易阶段饼图
            // getTransactionRefererOfAWebsiteCharts();

            //交易阶段折线图
            // getTransactionBasicLineCharts();

            //交易阶段漏斗图
            getTransactionFunnelCharts();

        })

        /**
         * 交易阶段柱状图绘制
         */
        function getTransactionBasicBarCharts(){
            $.ajax({
                url: "workbench/chart/transaction/getTransactionBasicBarCharts.do",
                type: "get",
                dataType: "json",
                success: function (data) {

                    // console.log(data.dataList);

                    // 基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document.getElementById('main1'));

                    option = {
                        xAxis: {
                            type: 'category',
                            // data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                            data: data.name
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            // data: [120, 200, 150, 80, 70, 110, 130],
                            data: data.value,
                            type: 'bar'
                        }]
                    };

                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);

                }
            })
        }

        /**
         * 交易阶段饼图绘制
         */
        function getTransactionRefererOfAWebsiteCharts(){
            $.ajax({
                url: "workbench/chart/transaction/getTransactionRefererOfAWebsiteCharts.do",
                type: "get",
                dataType: "json",
                success: function (data) {

                    console.log(data.dataList);

                    // 基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document.getElementById('main2'));

                    option = {
                        title: {
                            text: '交易饼图',
                            subtext: '统计交易阶段数量的饼图',
                            left: 'center'
                        },
                        tooltip: {
                            trigger: 'item'
                        },
                        legend: {
                            orient: 'vertical',
                            left: 'left'
                        },
                        series: [
                            {
                                name: '访问来源',
                                type: 'pie',
                                radius: '50%',
                                data: data.dataList,
                                    // [
                                    //     {value: 1048, name: '搜索引擎'},
                                    //     {value: 735, name: '直接访问'},
                                    //     {value: 580, name: '邮件营销'},
                                    //     {value: 484, name: '联盟广告'},
                                    //     {value: 300, name: '视频广告'}
                                    // ],
                                emphasis: {
                                    itemStyle: {
                                        shadowBlur: 10,
                                        shadowOffsetX: 0,
                                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                                    }
                                }
                            }
                        ]
                    };

                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);

                }
            })
        }

        /**
         * 交易阶段折线图绘制
         */
        function getTransactionBasicLineCharts(){
            $.ajax({
                url: "workbench/chart/transaction/getTransactionBasicLineCharts.do",
                type: "get",
                dataType: "json",
                success: function (data) {

                    // console.log(data.dataList);
                    // console.log(data.total);

                    // 基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document.getElementById('main3'));

                    option = {
                        xAxis: {
                            type: 'category',
                            data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            data: [150, 230, 224, 218, 135, 147, 260],
                            type: 'line'
                        }]
                    };

                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);

                }
            })
        }

        /**
         * 交易阶段漏斗图绘制
         */
        function getTransactionFunnelCharts(){
            $.ajax({
                url: "workbench/chart/transaction/getTransactionFunnelCharts.do",
                type: "get",
                dataType: "json",
                success: function (data) {

                    // console.log(data.dataList);
                    // console.log(data.total);

                    // 基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document.getElementById('main4'));

                    option = {
                        title: {
                            text: '交易漏斗图',
                            subtext: '统计交易阶段数量的漏斗图'
                        },
                        series: [
                            {
                                name:'交易漏斗图',
                                type:'funnel',
                                left: '10%',
                                top: 60,
                                //x2: 80,
                                bottom: 40,
                                width: '80%',
                                // height: {totalHeight} - y - y2,
                                min: 0,
                                max: data.total,
                                minSize: '0%',
                                maxSize: '100%',
                                sort: 'descending',
                                gap: 2,
                                label: {
                                    show: true,
                                    position: 'inside'
                                },
                                labelLine: {
                                    length: 10,
                                    lineStyle: {
                                        width: 1,
                                        type: 'solid'
                                    }
                                },
                                itemStyle: {
                                    borderColor: '#fff',
                                    borderWidth: 1
                                },
                                emphasis: {
                                    label: {
                                        fontSize: 20
                                    }
                                },
                                data: data.dataList
                                // [
                                // {value: 60, name: '访问'},
                                // {value: 40, name: '咨询'},
                                // {value: 20, name: '订单'},
                                // {value: 80, name: '点击'},
                                // {value: 100, name: '展现'}
                                // ]
                            }
                        ]
                    };

                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);

                }
            })
        }
    </script>

    <style>
        div{
            float: left;
            margin: 5px;
        }
    </style>
</head>
<body>
    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
    <%--柱状图：基础柱状图--%>
    <div id="main1" style="width: 600px;height:310px;border: 1px solid red;"></div>
    <%--饼图：某站点用户访问来源--%>
    <div id="main2" style="width: 600px;height:310px;border: 1px solid red;"></div>
    <%--折线图：基础折线图--%>
    <div id="main3" style="width: 600px;height:310px;border: 1px solid red;"></div>
    <%--漏斗图：基础漏斗图--%>
    <div id="main4" style="width: 600px;height:310px;border: 1px solid red;"></div>
</body>
</html>
