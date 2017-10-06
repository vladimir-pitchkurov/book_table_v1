<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<html>
<head>
    <title>Books Page</title>
    <style type="text/css">
        #myTable th {
            text-align: center;
            width: 80px;
            background-color: #ffcc00;
            border-color: #000000;
        }
        #myTable td{
            text-align: center;
            background-color: #cccccc;
            border-color: #000000;
        }
        .tg {
            border-collapse: collapse;
            border-spacing: 0;

        }
        .tg td {
            font-family: Arial, sans-serif;
            font-size: 14px;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;

        }
        .tg th {
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: normal;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
        }
    </style>
</head>
<body>
<a href="${pageContext.request.contextPath}../index.jsp" target="_parent">Back to main page</a>

<br/>


<h2>Books List</h2>

<c:if test="${!empty listBooks}">
    <table class="tg" id="myTable">
        <tr>
            <th width="80">ID</th>
            <th width="120">title</th>
            <th width="120">description</th>
            <th width="120">author</th>
            <th width="120">ISBN</th>
            <th width="120">printYear</th>
            <th width="120">readAlready</th>
            <th width="60">Edit</th>
            <th width="60">Delete</th>
            <th width="60">Read</th>
        </tr>
        <c:forEach items="${listBooks}" var="book">
            <tr>
                <td>${book.id}</td>
                <td><a href="/bookdata/${book.id}" target="_parent">${book.title}</a></td>
                <td>${book.description}</td>
                <td>${book.author}</td>
                <td>${book.isbn}</td>
                <td>${book.printYear}</td>
                <td>${book.readAlready}</td>
                <td><a href="<c:url value='/edit/${book.id}'/>">Edit</a></td>
                <td><a href="<c:url value='/remove/${book.id}'/>">Delete</a></td>
                <td><a href="<c:url value='/read/${book.id}'/>">Read</a></td>
            </tr>
        </c:forEach>
    </table>

</c:if>


<h2>Add Book</h2>

<c:url var="addAction" value="/books/add"/>

<form:form action="${addAction}" commandName="book">
    <table>
        <c:if test="${!empty book.title}">
            <tr>
                <td>
                    <form:label path="id">
                        <spring:message text="ID"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="id" readonly="true" size="8" disabled="true"/>
                    <form:hidden path="id"/>
                </td>
            </tr>
        </c:if>
        <tr>
            <td>
                <form:label path="title">
                    <spring:message text="Title"/>
                </form:label>
            </td>
            <td>
                <form:input path="title"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="description">
                    <spring:message text="Description"/>
                </form:label>
            </td>
            <td>
                <form:input path="description"/>
            </td>
        </tr>
        <c:if test="${!empty book.title}">
            <tr>
                <td>
                    <form:label path="author">
                        <spring:message text="author"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="author" readonly="true" size="8" disabled="true"/>
                    <form:hidden path="author"/>
                </td>
            </tr>
        </c:if>
        <c:if test="${empty book.title}">
            <tr>
                <td>
                    <form:label path="author">
                        <spring:message text="author"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="author" />

                </td>
            </tr>
        </c:if>
        <tr>
            <td>
                <form:label path="isbn">
                    <spring:message text="ISBN"/>
                </form:label>
            </td>
            <td>
                <form:input path="isbn"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="printYear">
                    <spring:message text="printYear"/>
                </form:label>
            </td>
            <td>
                <form:input path="printYear"/>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <c:if test="${!empty book.title}">
                    <input type="submit"
                           value="<spring:message text="Edit Book"/>"/>
                </c:if>
                <c:if test="${empty book.title}">
                    <input type="submit"
                           value="<spring:message text="Add Book"/>"/>
                </c:if>
            </td>
        </tr>
    </table>
</form:form>
<script type="text/javascript">
    // get the table element
    var $table = document.getElementById("myTable"),
// number of rows per page
        $n = 10,
// number of rows of the table
        $rowCount = $table.rows.length,
// get the first cell's tag name (in the first row)
        $firstRow = $table.rows[0].firstElementChild.tagName,
// boolean var to check if table has a head row
        $hasHead = ($firstRow === "TH"),
// an array to hold each row
        $tr = [],
// loop counters, to start count from rows[1] (2nd row) if the first row has a head tag
        $i,$ii,$j = ($hasHead)?1:0,
// holds the first row if it has a (<TH>) & nothing if (<TD>)
        $th = ($hasHead?$table.rows[(0)].outerHTML:"");
    // count the number of pages
    var $pageCount = Math.ceil($rowCount / $n);
    // if we had one page only, then we have nothing to do ..
    if ($pageCount > 1) {
        // assign each row outHTML (tag name & innerHTML) to the array
        for ($i = $j,$ii = 0; $i < $rowCount; $i++, $ii++)
            $tr[$ii] = $table.rows[$i].outerHTML;
        // create a div block to hold the buttons
        $table.insertAdjacentHTML("afterend","<div id='buttons'></div");
        // the first sort, default page is the first one
        sort(1);
    }

    // ($p) is the selected page number. it will be generated when a user clicks a button
    function sort($p) {
        /* create ($rows) a variable to hold the group of rows
        ** to be displayed on the selected page,
        ** ($s) the start point .. the first row in each page, Do The Math
        */
        var $rows = $th,$s = (($n * $p)-$n);
        for ($i = $s; $i < ($s+$n) && $i < $tr.length; $i++)
            $rows += $tr[$i];

        // now the table has a processed group of rows ..
        $table.innerHTML = $rows;
        // create the pagination buttons
        document.getElementById("buttons").innerHTML = pageButtons($pageCount,$p);
        // CSS Stuff
        document.getElementById("id"+$p).setAttribute("class","active");
    }


    // ($pCount) : number of pages,($cur) : current page, the selected one ..
    function pageButtons($pCount,$cur) {
        /* this variables will disable the "Prev" button on 1st page
           and "next" button on the last one */
        var $prevDis = ($cur == 1)?"disabled":"",
            $nextDis = ($cur == $pCount)?"disabled":"",
            /* this ($buttons) will hold every single button needed
            ** it will creates each button and sets the onclick attribute
            ** to the "sort" function with a special ($p) number..
            */
            $buttons = "<input type='button' value='&lt;&lt; Prev' onclick='sort("+($cur - 1)+")' "+$prevDis+">";
        for ($i=1; $i<=$pCount;$i++)
            $buttons += "<input type='button' id='id"+$i+"'value='"+$i+"' onclick='sort("+$i+")'>";
        $buttons += "<input type='button' value='Next &gt;&gt;' onclick='sort("+($cur + 1)+")' "+$nextDis+">";
        return $buttons;
    }
</script>
</body>
</html>