<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:t="http://xproc.org/ns/testsuite/3.0"
                xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="c h p t xs"
                version="2.0">

<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>

<xsl:template match="/">
  <xsl:apply-templates mode="alphabetical"/>
  <xsl:apply-templates mode="expected"/>
  <xsl:apply-templates mode="element"/>
  <xsl:apply-templates mode="implementation"/>
  <xsl:apply-templates mode="bydate"/>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="c:directory" mode="alphabetical">
  <xsl:result-document href="/fakeroot/alphabetical.html">
    <html>
      <head>
        <meta charset="utf-8"/>
        <title>Alphabetical index</title>
        <link href="css/testsuite.css" rel="stylesheet" type="text/css" />
     </head>
      <body>
        <nav>
          <a href="index.html">↑</a>
        </nav>
        <h1>Alphabetical index</h1>
        <ul>
          <xsl:for-each select="t:test">
            <xsl:variable name="href" select="substring-after(@xml:base, '/tests/')"/>
            <li>
              <xsl:sequence select="t:test-link($href)"/>
              <xsl:text>: </xsl:text>
              <xsl:value-of select="t:info/t:title"/>
            </li>
          </xsl:for-each>
        </ul>
      </body>
    </html>
  </xsl:result-document>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="c:directory" mode="expected">
  <xsl:result-document href="/fakeroot/expected.html">
    <html>
      <head>
        <meta charset="utf-8"/>
        <title>Expectation index</title>
        <link href="css/testsuite.css" rel="stylesheet" type="text/css" />
      </head>
      <body>
        <nav>
          <a href="index.html">↑</a>
        </nav>
        <h1>Expectation index</h1>
        <h2>Expected to pass</h2>
        <ul>
          <xsl:for-each select="t:test[@expected='pass']">
            <xsl:variable name="href" select="substring-after(@xml:base, '/tests/')"/>
            <li>
              <xsl:sequence select="t:test-link($href)"/>
            </li>
          </xsl:for-each>
        </ul>
        <h2>Expected to fail</h2>
        <ul>
          <xsl:for-each select="t:test[@expected='fail']">
            <xsl:variable name="href" select="substring-after(@xml:base, '/tests/')"/>
            <li>
              <xsl:sequence select="t:test-link($href)"/>
            </li>
          </xsl:for-each>
        </ul>
      </body>
    </html>
  </xsl:result-document>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="c:directory" mode="element">
  <xsl:result-document href="/fakeroot/element.html">
    <html>
      <head>
        <meta charset="utf-8"/>
        <title>Element index</title>
        <link href="css/testsuite.css" rel="stylesheet" type="text/css" />
      </head>
      <body>
        <nav>
          <a href="index.html">↑</a>
        </nav>
        <h1>Element index</h1>

        <xsl:variable name="tests" select="."/>

        <xsl:variable name="all-elements" as="xs:QName*">
          <xsl:for-each select="t:test/t:pipeline//*">
            <xsl:sequence select="node-name(.)"/>
          </xsl:for-each>
        </xsl:variable>

        <xsl:variable name="elements" as="xs:QName*">
          <xsl:for-each select="distinct-values($all-elements)">
            <xsl:sort select="concat(namespace-uri-from-QName(.),local-name-from-QName(.))"/>
            <xsl:sequence select="."/>
          </xsl:for-each>
        </xsl:variable>

        <ul>
          <xsl:for-each select="$elements[namespace-uri-from-QName(.)='http://www.w3.org/ns/xproc']">
            <xsl:variable name="name" select="."/>
            <li>
              <xsl:text>p:</xsl:text>
              <xsl:value-of select="local-name-from-QName(.)"/>

              <ul>
                <xsl:for-each select="$tests/t:test[t:pipeline//*[node-name(.) = $name]]">
                  <xsl:variable name="href" select="substring-after(@xml:base, '/tests/')"/>
                  <li>
                    <xsl:sequence select="t:test-link($href)"/>
                  </li>
                </xsl:for-each>
              </ul>
            </li>
          </xsl:for-each>

          <xsl:for-each select="$elements[namespace-uri-from-QName(.)!='http://www.w3.org/ns/xproc']">
            <xsl:variable name="name" select="."/>
            <li>
              <xsl:if test="namespace-uri-from-QName(.) != ''">
                <xsl:text>{</xsl:text>
                <xsl:value-of select="namespace-uri-from-QName(.)"/>
                <xsl:text>}</xsl:text>
              </xsl:if>
              <xsl:value-of select="local-name-from-QName(.)"/>

              <ul>
                <xsl:for-each select="$tests/t:test[t:pipeline//*[node-name(.) = $name]]">
                  <xsl:variable name="href" select="substring-after(@xml:base, '/tests/')"/>
                  <li>
                    <xsl:sequence select="t:test-link($href)"/>
                  </li>
                </xsl:for-each>
              </ul>
            </li>
          </xsl:for-each>

        </ul>
      </body>
    </html>
  </xsl:result-document>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="c:directory" mode="implementation">
  <xsl:variable name="impl" select="(doc('../../reports/xml-calabash.xml')/*)"/>

  <xsl:result-document href="/fakeroot/implementation.html">
    <html>
      <head>
        <meta charset="utf-8"/>
        <title>Implementation index</title>
        <link href="css/testsuite.css" rel="stylesheet" type="text/css" />
      </head>
      <body>
        <nav>
          <a href="index.html">↑</a>
        </nav>
        <h1>Implementation index</h1>

        <table cellspacing="0" cellpadding="5">
          <thead>
            <tr>
              <th rowspan="2">Test</th>
              <xsl:for-each select="$impl">
                <th>
                  <xsl:value-of select="$impl/properties/property[@name='processor']/@value"/>
                </th>
              </xsl:for-each>
            </tr>
            <tr>
              <xsl:for-each select="$impl">
                <th>
                  <xsl:value-of select="$impl/properties/property[@name='version']/@value"/>
                </th>
              </xsl:for-each>
            </tr>
            <tr>
              <td>Listed on
                <xsl:value-of select='format-dateTime(current-dateTime(),
                                     "[D01] [MNn,*-3] [Y0001] at [H01]:[m01]")'/>
              </td>
              <xsl:for-each select="$impl">
                <td>Run on
                <xsl:value-of select='format-dateTime(xs:dateTime($impl/@timestamp),
                                     "[D01] [MNn,*-3] [Y0001] at [H01]:[m01]")'/>
                </td>
              </xsl:for-each>
            </tr>              
          </thead>
          <tbody>
            <xsl:for-each select="t:test">
              <xsl:variable name="href" select="substring-after(@xml:base, '/tests/')"/>
              <tr>
                <td>
                  <xsl:sequence select="t:test-link($href)"/>
                </td>
                <xsl:for-each select="$impl">
                  <xsl:variable name="report" select="$impl/testcase[@name=$href]"/>
                  <xsl:choose>
                    <xsl:when test="$report/failure">
                      <td class="fail" align="center">fail</td>
                    </xsl:when>
                    <xsl:when test="exists($report)">
                      <td class="pass" align="center">pass</td>
                    </xsl:when>
                    <xsl:otherwise>
                      <td align="center">???</td>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </tr>
            </xsl:for-each>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:result-document>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="c:directory" mode="bydate">
  <xsl:result-document href="/fakeroot/date.html">
    <html>
      <head>
        <meta charset="utf-8"/>
        <title>Date index</title>
        <link href="css/testsuite.css" rel="stylesheet" type="text/css" />
      </head>
      <body>
        <nav>
          <a href="index.html">↑</a>
        </nav>
        <h1>Date index</h1>
        <dl>
          <xsl:for-each-group select="t:test" group-by="@log-date">
            <xsl:sort select="@log-date" order="descending"/>
            <dt>
              <xsl:value-of select="current-grouping-key()"/>
            </dt>
            <dd>
              <ul>
                <xsl:for-each select="current-group()">
                  <xsl:sort select="@xml:base"/>
                  <xsl:variable name="href" select="substring-after(@xml:base, '/tests/')"/>
                  <li>
                    <xsl:sequence select="t:test-link($href)"/>

                    <!-- there was a massive refactor on 2018-10-09 and 2018-10-10 -->
                    <xsl:variable name="cutoff" select="xs:date('2018-10-10')"/>
                    <xsl:variable name="fuzz" select="xs:dayTimeDuration('P1D')"/>
                    <xsl:variable name="log-date" select="xs:date(current-grouping-key())"/>
                    <xsl:variable name="rev-date"
                                  select="xs:date(substring(
                                             t:info/t:revision-history/t:revision[1]/t:date, 1, 10))"/>

                    <xsl:if test="$cutoff lt $log-date
                                  and ($log-date - $rev-date) gt $fuzz">
                      <xsl:text> (Last posted revision date seems too old: </xsl:text>
                      <xsl:value-of select="$log-date - $rev-date"/>
                      <xsl:text>)</xsl:text>
                    </xsl:if>
                  </li>
                </xsl:for-each>
              </ul>
            </dd>
          </xsl:for-each-group>
        </dl>
      </body>
    </html>
  </xsl:result-document>
</xsl:template>

<!-- ============================================================ -->

<xsl:function name="t:test-link">
  <xsl:param name="xml"/>
  <xsl:variable name="name" select="substring-before($xml, '.xml')"/>

  <a href="tests/{$name}.html">
    <xsl:value-of select="$name"/>
  </a>
</xsl:function>

</xsl:stylesheet>