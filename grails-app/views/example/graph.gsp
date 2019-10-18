<%@ page import="org.joda.time.Duration; groovy.time.TimeDuration; au.org.ala.webapi.ExampleRun" %>
<%@ page import="grails.converters.JSON" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <g:set var="entityName" value="${message(code: 'example.label', default: 'Example')}" />
    <title>History | ${grailsApplication.config.skin.orgNameLong}</title>
    <meta name="breadcrumbs" content="${createLink(uri: '/')},${grailsApplication.config.application.title}"/>
    <meta name="breadcrumb" content="History"/>
    <asset:stylesheet src="webapi"/>
    <asset:javascript src="d3.min.js"/>
    <style type="text/css">
    .inline {
        display: inline-block;
        font-weight: normal;
        padding-right: 10px;
    }
    line {
        stroke: black;
    }
    .indicator {
        cursor: pointer;
    }
    .okdot {
        stroke: green;
        fill: green;
    }
    .slowdot {
        stroke: blue;
        fill: blue;
    }
    .warndot {
        stroke: orange;
        fill: orange;
    }
    .errordot {
        stroke: red;
        fill: red;
    }

    path {
        fill: none;
        stroke: green;
    }
    .axis path,
    .axis line {
        fill: none;
        stroke: black;
        shape-rendering: crispEdges;
    }

    .axis text {
        font-family: sans-serif;
        font-size: 11px;
    }
    </style>
</head>
<body>
<a href="#show-example" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<ul class="breadcrumb" role="navigation">
    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a> <span class="divider"><i class="fa fa-arrow-right"></i></span></li>
    <li class="active"><g:message code="default.show.label" args="[entityName]" /> History</li>
</ul>

<div id="show-example" class="content scaffold-show" role="main">
    <h1><g:fieldValue bean="${example}"
                      field="name"/>
    <g:link class="show btn btn-primary pull-right" controller="example" action="show" id="${example.id}"><g:message code="default.show.label" args="[entityName]" /></g:link>
    </h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <g:if test="${example?.description}">
        <div class="well"><markdown:renderHtml text="${example.description}" /></div>
    </g:if>

    <g:if test="${sortedRuns}">
        <h2>Responses for the past 72 hours</h2>
        <h3>Response graph</h3>
        <div id="graph"></div>
        <h3 class="inline">Slow Responses</h3> <svg width="7" height="7" style="display: inline-block"><circle class="slowdot" cx="3.5" cy="3.5" r="3.5"/></svg>
        <table class="table table-striped table-bordered table-condensed">
            <thead>
            <tr>
                <th>URL</th>
                <th>When</th>
                <th>Duration</th>
                <th>Response Code</th>
                <th>Response Body</th>
            </tr>
            </thead>
            <tbody>
            <g:findAll in="${sortedRuns}" expr="10000 < it.duration">
                <tr>
                    <td><a href="${it.url}">${it.url}</a></td>
                    <td>${it.start}</td>
                    <td><joda:formatPeriod value="${new Duration(it.duration)}" /></td>
                    <td>${it.responseCode}</td>
                    <td><a href="${createLink(controller: 'exampleRun', action: 'response', id: it.id)}">Response Body</a></td>
                </tr>
            </g:findAll>
            </tbody>
        </table>
        <h3 class="inline">Unsuccessful HTTP Responses</h3> <svg width="7" height="7"><circle class="warndot" cx="3.5" cy="3.5" r="3.5"/></svg>
        <table class="table table-striped table-bordered table-condensed">
            <thead>
            <tr>
                <th>URL</th>
                <th>When</th>
                <th>Duration</th>
                <th>Response Code</th>
                <th>Response Body</th>
            </tr>
            </thead>
            <tbody>
            <g:findAll in="${sortedRuns}" expr="!it.clazz.contains('Failure') && 299 < it.responseCode ">
                <tr>
                    <td><a href="${it.url}">${it.url}</a></td>
                    <td>${it.start}</td>
                    <td><joda:formatPeriod value="${new Duration(it.duration)}" /></td>
                    <td>${it.responseCode}</td>
                    <td><a href="${createLink(controller: 'exampleRun', action: 'response', id: it.id)}">Response Body</a></td>
                </tr>
            </g:findAll>
            </tbody>
        </table>
        <h3 class="inline">Network Error requests</h3> <svg width="7" height="7"><circle class="errordot" cx="3.5" cy="3.5" r="3.5"/></svg>
        <table class="table table-striped table-bordered table-condensed">
            <thead>
                <tr>
                    <th>When</th>
                    <th>Duration</th>
                    <th>Response Code</th>
                </tr>
            </thead>
            <tbody>
                <g:findAll in="${sortedRuns}" expr="it.responseCode == null">
                    <tr>
                        <td>${it.start}</td>
                        <td><joda:formatPeriod value="${new Duration(it.duration)}" /></td>
                        <td>${it.exceptionClass.substring(it.exceptionClass.lastIndexOf('.')+1) + ": " + it.message}</td>
                    </tr>
                </g:findAll>
            </tbody>
        </table>
        <asset:script defer="true">

            'use strict';

            $(function() {

                function escapeHTML(html) {
                    return html.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
                }

                var w = 668,
                    h = 300,
                    p = 100;

                var between = function (x, min, max) {
                    return x >= min && x <= max;
                };

                var data =${encodeAs([codec: 'raw'], (sortedRuns as JSON).toString())},
                        scaleX = d3.time.scale().domain([Date.parse(data[0].start), Date.parse(data[data.length - 1].start)]).range([0, w]),
                        scaleY = d3.scale.linear().domain([0, Math.min(${max.duration}, 10000)]).range([h, 0]).clamp(true);
                var svg = d3.select('div#graph')
                        .data([data])
                        .append("svg:svg")
                        .attr("width", w + p * 2)
                        .attr("height", h + p * 2)
                        .append("svg:g")
                        .attr("transform", "translate(" + p + "," + p + ")");

                //Define X axis
                var xAxis = d3.svg.axis()
                        .scale(scaleX)
                        .orient("bottom")
                        .ticks(10);  //Set rough # of ticks

                //Define Y axis
                var yAxis = d3.svg.axis()
                        .scale(scaleY)
                        .orient("left")
                        .ticks(5);

                //Create X axis
                svg.append("g")
                        .attr("class", "axis")  //Assign "axis" class
                        .attr("transform", "translate(0," + (h) + ")")
                        .call(xAxis);

                svg.append("text")
                        .attr("transform", "translate(" + (w / 2) + ", " + (h + p/2) + ")")
                        .style("text-anchor", "middle")
                        .text("When");


                //Create Y axis
                svg.append("g")
                        .attr("class", "axis")
                    //.attr("transform", "translate(" + p + ",0)")
                        .call(yAxis);

                svg.append("text")
                        .attr("transform", "rotate(-90)")
                        .attr("y", 0 - p)
                        .attr("x", 0 - (h / 2))
                        .attr("dy", "1em")
                        .style("text-anchor", "middle")
                        .text("Duration (ms)");

                // Add response line
                svg.append("svg:path")
                        .attr("class", "line")
                        .attr("d", d3.svg.line()
                                .x(function (d) {
                                    return scaleX(Date.parse(d.start));
                                })
                                .y(function (d) {
                                    return scaleY(d.duration);
                                })
                                .defined(function (d) {
                                    return d.clazz.indexOf("Failure") == -1;
                                })
                                .interpolate("linear")

                );

                // Add points for each actual request
                svg.selectAll("circle.indicator")
                        .data(data)
                        .enter().append("svg:circle")
                        .attr("class", function (d) {
                            return (d.clazz.indexOf("Failure") != -1 ? "errordot" : !between(d.responseCode, 200, 299) ? "warndot" : d.duration > 10000 ? "slowdot" : "okdot") + " indicator";
                        })
                        .attr("cx", function (d) {
                            return scaleX(Date.parse(d.start));
                        })
                        .attr("cy", function (d) {
                            return scaleY(d.duration);
                        })
                        .attr("r", 3.5)
                        .attr("data-toggle", "popover") // marks element as owning a popover
                        .attr("data-title", function(d, i) {
                            return new Date(d.start).toTimeString();
                        })
                        .attr("data-content", function(d, i) {
                            var common = '<dl><dt>URL</dt><dd><a href="'+ escapeHTML(d.url) +'">Link</a></dd><dt>Duration</dt><dd>' + d.duration + 'ms</dd>';
                            if (d.responseCode) {
                                var prefix = '${createLink(controller:"exampleRun", action:"response").encodeAsJavaScript()}/';
                                return common + '<dt>Response Code</dt><dd>'+d.responseCode+'</dd><dt>Response Body</dt><dd><a href="'+ escapeHTML(prefix+d.id) +'">Link</a></dd></dl>';
                            }
                            else {
                                return common + '<dt>Error</dt><dd>' + d.exceptionClass.substring(d.exceptionClass.lastIndexOf('.')+1) + ": " + d.message + '</dd></dl>';
                            }
                        });

                var indicators = $('.indicator');
                indicators.popover({container:"body", "trigger": "click", placement: "right", html: true});

                // Close open popover on click
                $('body').on('click', function (e) {
                    $('[data-toggle="popover"]').each(function () {
                        //the 'is' for buttons that trigger popups
                        //the 'has' for icons within a button that triggers a popup
                        var isNotTarget = !$(this).is(e.target);
                        var hasNoTarget = $(this).has(e.target).length === 0;
                        var noPopoverWithTarget =  $('.popover').has(e.target).length === 0;

                        if (isNotTarget && hasNoTarget && noPopoverWithTarget) {
                            $(this).popover('hide');
                        }
                    });
                });
            });

        </asset:script>
    </g:if>
    <g:else>
        <div class="well well-large">
            <p class="lead">This example has not been run in the past 72 hours</p>
        </div>
    </g:else>
</div>
</body>
</html>
