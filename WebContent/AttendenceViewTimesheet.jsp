<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="UTF-8">
        <title>タイムシート</title>
<link rel="stylesheet" href="common/css/style.css">
</head>
<body>
    <div class="header">
        <span class="big_title">H</span>eets <span class="big_title">C</span>orporation
    </div>

    <div class= "menu">
    <div class= "main_frame">
        <p>タイムシート</p>
    </div>
    </div>
        <div class="name_format">
            名前：<%= session.getAttribute("employeeName") %>
        </div>
        <div class="name_format">
            <%= thisMonthCalendar.get(Calendar.YEAR) + "年"
        + thisMonthCalendar.get(Calendar.MONTH) + "月" %>分
        </div>

        <div class="edit_top">
        <div class="show_all_table"><table>
        <tr class="top_table"><th>日にち</th><th>出勤</th><th>退勤</th><th>休憩入り</th><th>休憩戻り</th>
        <th>休憩時間</th><th>実働時間</th></tr>

        <%
            thisMonthCalendar.add(Calendar.MONTH, -1);
            int dayOfMonth = thisMonthCalendar.getActualMaximum(Calendar.DAY_OF_MONTH);
            thisMonthCalendar.add(Calendar.MONTH, 1);
            DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("HH時mm分");
            DateTimeFormatter hourFormat = DateTimeFormatter.ofPattern("HH時間mm分");
            for(int i = 1; i <= dayOfMonth; i++) {
                Boolean chkDateFlag = false;
        %>
                <tr class="main_table"><td><%= thisMonthCalendar.get(Calendar.MONTH) + "月" + i + "日" %></td>

            <%
                for(WorkTime workTime: workTimeThisMonthList) {
                String workDate =
                        workTime.getWorkdate().format(DateTimeFormatter.ofPattern("dd"));
                    if(Integer.parseInt(workDate) == i) {
            %>
                        <td><% if(workTime.getStartTime() != null) { %>
                        <%= workTime.getStartTime().format(timeFormat) %><% } %></td>
                        <td><% if(workTime.getFinishTime() != null) { %>
                        <%= workTime.getFinishTime().format(timeFormat) %><% } %></td>
                        <td><% if(workTime.getBreakStartTime() != null) { %>
                        <%= workTime.getBreakStartTime().format(timeFormat) %><% } %></td>
                        <td><% if(workTime.getBreakFinishTime() != null) { %>
                        <%= workTime.getBreakFinishTime().format(timeFormat) %><% } %></td>
                        <td><% if(workTime.getBreakTime() != null) {%>
                        <%= hourFormat.format(LocalTime.MIDNIGHT.plus(workTime.getBreakTime())) %>
                        <% } %></td>
                        <td><% if(workTime.getWorkingHours() != null) { %>
                        <%= hourFormat.format(LocalTime.MIDNIGHT.plus(workTime.getWorkingHours())) %>
                        <% } %></td></tr>
            <%
                        chkDateFlag = true;
                        break;
                    }
                }
                if(!chkDateFlag) {
            %>
                    <td></td><td></td><td></td><td></td><td></td><td></td></tr>

        <%
                }
            }
        %>


        </table></div></div>


        <div class="signature_form"><table border="1">
        <tr><th>本人印</th><th>承認印</th></tr>
        <tr><td>&nbsp;</td><td>&nbsp;</td></tr>

        </table></div>
        <div class="link_button">
            <a href="AttendanceMenu.jsp">
                <button class="display_button">メニュー画面に戻る</button>
            </a>
        </div>

    <div class="footer_top">
        <table class="table_format">

            <tr>
                <th>管理者情報</th>
            </tr>
            <tr>
                <td class="cel">会社名</td>
                <td>&nbsp;</td>
                <td>HEETS 株式会社</td>
            </tr>
            <tr>
                <td class="cel">Tell</td>
                <td>&nbsp;</td>
                <td>03-0000-0000</td>
            <tr>
                <td class="cel">Email</td>
                <td>&nbsp;</td>
                <td>heets.tbc@gmail.com</td>
            </tr>
        </table>
    </div>

    <div class="footer_design">
        <footer>
            <small>© 2022 HEETS corporation</small>
        </footer>
    </div>
</body>
</html>