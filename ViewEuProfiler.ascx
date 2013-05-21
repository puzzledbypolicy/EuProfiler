<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewEuProfiler.ascx.cs"
    Inherits="ATC.Modules.EuProfiler.ViewEuProfiler" %>
<div id="menu">
    <div id="menuinner_left">
    </div>
    <div id="menuinner_middle">
        <ul class="headmenu">
            <li>
                <div class="menuItem">
                    <asp:LinkButton ID="HomeLink" runat="server" CssClass="selected" resourcekey="HomeLbl" />
                </div>
                <div class="headmenu_sep">
                </div>
            </li>
            <li>
                <div class="menuItem">
                    <asp:LinkButton ID="IssuesLink" runat="server" resourcekey="Issues" />
                </div>
                <div class="headmenu_sep">
                </div>
            </li>
            <li>
                <div class="menuItem">
                    <asp:LinkButton ID="ResultsLink" runat="server" resourcekey="ResultsLbl" />
                </div>
            </li>
        </ul>
    </div>
    <div id="menuinner_right">
    </div>
</div>
<div class="dnnFormMessage dnnFormInfo" style="display: none;">
    <asp:Label ID="ResultsWrnLbl" runat="server" resourcekey='ResultsWrn' />
</div>

<asp:ListView ID="CategoriesDataList" runat="server" DataSourceID="SqlCategories"
    OnItemDataBound="CategoriesDataList_ItemDatabound" OnDataBound="CategoriesDataList_DataBound"
    ItemPlaceholderID="categoriesPlaceh">
    <LayoutTemplate>
        <div id="questionnaire" runat="server">
            <asp:Panel ID="IntroPanel" runat="server">
                <div id="start">
                    <div id="startLanguageSelection">
                        <asp:Label ID="ChooseCountryLbl" runat="server" resourcekey="ChooseCountryRes" />
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:DropDownList ID="LanguageSelector" runat="server" AutoPostBack="True" OnSelectedIndexChanged="languageSelector_SelectedIndexChanged"
                            Width="150">
                            <asp:ListItem Text="Ελλάδα" Value="el-GR" resourcekey="GrLabel" />
                            <asp:ListItem Text="Italia" Value="it-IT" resourcekey="ItLabel" />
                            <asp:ListItem Text="Εspaña" Value="es-ES" resourcekey="EsLabel" />
                            <asp:ListItem Text="Magyarország" Value="hu-HU" resourcekey="HuLabel" />
                            <asp:ListItem Text="Other" Value="en-GB" resourcekey="EuLabel" />
                        </asp:DropDownList>
                    </div>
                    <asp:LinkButton ID="StartButton" runat="server">&nbsp;</asp:LinkButton>
                </div>
            </asp:Panel>
            <asp:PlaceHolder ID="categoriesPlaceh" runat="server"></asp:PlaceHolder>
            <div id="summaryScreen" class="Summary" style="display: none">
                <div id="summaryMsg">
                    <h1>
                        <asp:Label ID="SummaryLbl" runat="server" resourcekey="SummaryLbl" /></h1>
                </div>
                <div class="summaryHeader">
                    <asp:Label ID="AnswersLbl" runat="server" resourcekey="AnswersLbl" /></h1>
                </div>
                <div class="summaryHeader">
                    <asp:Label ID="RatingsLbl" runat="server" resourcekey="RatingsLbl" /></h1>
                </div>
                <div id="summaryList">
                </div>
                <div id="final_right_bckgr">
                </div>
                <div class="ResultsNav">
                    <asp:LinkButton ID="DemographicsBtn" runat="server" OnClick="FinishButton_Click"
                        Text=" " />
                </div>
            </div>
            <div id="demographicsScreen" class="Summary" style="display: none">
                <div id="demographicsMessage">
                    <asp:Label ID="DemographicsLbl" runat="server" resourcekey="demographicsHeader" />
                </div>
                <div class="demog_questions">
                    <div class="demog_question">
                        <asp:Label ID="demog1" runat="server" resourcekey="q1Label" /></div>
                    <div class="demog_answer">
                        <asp:DropDownList ID="BirthPlaceDropD" runat="server" OnDataBound="BirthPlaceDropD_DataBound"
                            DataSourceID="SqlCountryNames" Width="323" DataTextField="value" DataValueField="value" />
                    </div>
                    <div class="demog_question">
                        <asp:Label ID="demog2" runat="server" resourcekey="q2Label" /></div>
                    <div class="demog_answer">
                        <asp:DropDownList ID="LivingPlaceDropD" runat="server" OnDataBound="LivingPlaceDropD_DataBound"
                            DataSourceID="SqlCountryNames" Width="323" DataTextField="value" DataValueField="value" />
                    </div>
                    <div class="demog_question">
                        <asp:Label ID="demog3" runat="server" resourcekey="q3Label" /></div>
                    <div class="demog_answer">
                        <div style="width: 335px">
                            <asp:DropDownList ID="ageDropD" runat="server" Width="70">
                                <asp:ListItem Value="13-17" Text="13-17" />
                                <asp:ListItem Value="18-24" Text="18-24" />
                                <asp:ListItem Value="25-34" Text="25-34" />
                                <asp:ListItem Value="35-44" Text="35-44" />
                                <asp:ListItem Value="45-54" Text="45-54" />
                                <asp:ListItem Value="55+" Text="55+" />
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="demog_question">
                        <asp:Label ID="demog4" runat="server" resourcekey="q4Label" /></div>
                    <div class="demog_answer">
                        <asp:RadioButtonList ID="sexRadios" RepeatDirection="Horizontal" ForeColor="#ffffff"
                            runat="server">
                            <asp:ListItem Value="Male" Text="Male" resourcekey="SexMale" />
                            <asp:ListItem Value="Female" Text="Female" resourcekey="SexFemale" />
                        </asp:RadioButtonList>
                    </div>
                    <div class="demog_question">
                        <asp:Label ID="demog5" runat="server" resourcekey="q5Label" /></div>
                    <div class="demog_answer">
                        <asp:DropDownList ID="EducationDropD" runat="server">
                            <asp:ListItem Value="High school" Text="High school" resourcekey="Education1" />
                            <asp:ListItem Value="College degree" Text="College degree" resourcekey="Education2" />
                            <asp:ListItem Value="MSc" Text="MSc" resourcekey="Education3" />
                            <asp:ListItem Value="Doctoral" Text="Doctoral" resourcekey="Education4" />
                            <asp:ListItem Value="Other" Text="Other" resourcekey="Education5" />
                        </asp:DropDownList>
                    </div>
                    <div class="demog_question">
                        <asp:Label ID="demog6" runat="server" resourcekey="q6Label" /></div>
                    <div class="demog_answer">
                        <asp:DropDownList ID="occupationDropD" runat="server">
                            <asp:ListItem Value="- choose one -" Text="- choose one -" resourcekey="Occupation0" />
                            <asp:ListItem Value="Business owner (employer)" Text="Business owner (employer)" resourcekey="Occupation1" />
                            <asp:ListItem Value="Own-account worker (self-employed)" Text="Own-account worker (self-employed)" resourcekey="Occupation2" />
                            <asp:ListItem Value="Manager" Text="Manager" resourcekey="Occupation3" />
                            <asp:ListItem Value="Employee" Text="Employee" resourcekey="Occupation4" />
                            <asp:ListItem Value="Jobseeker" Text="Jobseeker" resourcekey="Occupation5" />
                            <asp:ListItem Value="Housewife / Homemaker / On maternity leave" Text="Housewife / Homemaker / On maternity leave" resourcekey="Occupation6" />
                            <asp:ListItem Value="Student" Text="Student" resourcekey="Occupation7" />
                            <asp:ListItem Value="Retired" Text="Retired" resourcekey="Occupation8" />
                            <asp:ListItem Value="Unable to work" Text="Unable to work" resourcekey="Occupation9" />
                            <asp:ListItem Value="Other" Text="Other" resourcekey="Occupation10" />
                            <asp:ListItem Value="n/a" Text="n/a" resourcekey="Occupation11" />
                        </asp:DropDownList>                       
                    </div>
                    <!-- Only for the spanish questionnaire -->
                    <div class="demog_question Spanish">
                        <asp:Label ID="demog7" runat="server" Text="Municipio" /></div>
                    <div class="demog_answer Spanish">
                        <div style="width: 335px">
                            <asp:TextBox ID="MunicipalityText" Width="250px" runat="server" /></div>
                    </div>
                </div>
                <div id="DemographicsNav">
                    <asp:LinkButton ID="FinishBtn" runat="server" OnClick="FinishButton_Click" OnClientClick="javascript:completeQuestionnaire();"
                        Text=" " />
                    <asp:LinkButton ID="SubmitDemogBtn" runat="server" OnClientClick="javascript:completeDemographics();"
                        OnClick="FinishButton_Click" Text="submit " />
                </div>
            </div>
        </div>
    </LayoutTemplate>
    <ItemTemplate>
        <div id="cat-<%# Eval("CategoryID") %>" class="category" style="display: none">
            <asp:HiddenField ID="ParentCategoryID" Value='<%# Eval("CategoryID") %>' runat="server" />
            <asp:HiddenField ID="CategoryLocale" Value='<%# Eval("Locale") %>' runat="server" />
            <asp:HiddenField ID="CategoryTargetedCountry" Value='<%# Eval("TargetedCountry") %>'
                runat="server" />
            <div class="catTitle">
                <%# Eval("CategoryText") %>
            </div>
            <div id="meter">
                <div class="meter-wrap">
                    <div style="text-align: left">
                        <div class="meter-value" style="background-color: #2fa1a1; width: 0%;">
                            <div class="meter-text">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <asp:ListView ID="QuestionsDataList" runat="server" DataSourceID="SqlQuestions" ItemPlaceholderID="questionsPlaceh">
                <LayoutTemplate>
                    <asp:PlaceHolder ID="questionsPlaceh" runat="server"></asp:PlaceHolder>
                </LayoutTemplate>
                <ItemTemplate>
                    <div id="question<%# Eval("QuestionID") %>" class="questionContainer">
                        <asp:HiddenField ID="QuestionLocale" Value='<%# Eval("Locale") %>' runat="server" />
                        <div class="question">
                            <%# Eval("QuestionText")%>
                        </div>
                        <div class="starRating">
                            <div class="title">
                                <asp:Label ID="RatingLbl" runat="server" resourcekey="RatingLbl" /></div>
                            <span id="stars-cap<%# Eval("QuestionID") %>"></span>
                            <div id="stars-wrapper<%# Eval("QuestionID") %>" class="stars">
                                <input type="radio" name="quesrate" value="1" title=" " />
                                <input type="radio" name="quesrate" value="2" title=" " />
                                <input type="radio" name="quesrate" value="3" title=" " />
                            </div>
                        </div>
                        <div class="question_sep">
                        </div>
                        <asp:ListView ID="AnswersDataList" runat="server" DataSourceID="SqlAnswers" ItemPlaceholderID="answersPlaceh">
                            <LayoutTemplate>
                                <ul class="answers">
                                    <asp:PlaceHolder ID="answersPlaceh" runat="server"></asp:PlaceHolder>
                                </ul>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <li>
                                    <div class="outer">
                                        <a href="<%# Eval("AnswerID")%>" class="answer"><span>
                                            <%# Eval("AnswerText")%></span> </a>
                                    </div>
                                    <div class="menu_sep">
                                    </div>
                                </li>
                            </ItemTemplate>
                        </asp:ListView>
                        <asp:SqlDataSource ID="SqlAnswers" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
                            SelectCommand="SELECT [AnswerID], [AnswerText] FROM [ATC_PolicyProfiler_Answers] WHERE ([Locale] = @Locale)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="QuestionLocale" Name="Locale" PropertyName="Value" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                    <div style="clear: both">
                    </div>
                </ItemTemplate>
            </asp:ListView>
            <asp:SqlDataSource ID="SqlQuestions" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
                SelectCommand="SELECT ATC_PolicyProfiler_Questions.Locale, ATC_PolicyProfiler_Questions.QuestionID, ATC_PolicyProfiler_Questions.QuestionText FROM ATC_PolicyProfiler_Categories INNER JOIN ATC_PolicyProfiler_Questions ON ATC_PolicyProfiler_Categories.CategoryID = ATC_PolicyProfiler_Questions.CategoryID AND ATC_PolicyProfiler_Categories.Locale = ATC_PolicyProfiler_Questions.Locale AND ATC_PolicyProfiler_Categories.TargetedCountry = ATC_PolicyProfiler_Questions.TargetedCountry WHERE (ATC_PolicyProfiler_Categories.Locale = @Locale) AND (ATC_PolicyProfiler_Categories.TargetedCountry = @TargetedCountry) AND (ATC_PolicyProfiler_Categories.CategoryID = @CategoryID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ParentCategoryID" Name="CategoryID" PropertyName="Value" />
                    <asp:ControlParameter ControlID="CategoryLocale" Name="Locale" PropertyName="Value" />
                    <asp:ControlParameter ControlID="CategoryTargetedCountry" Name="TargetedCountry"
                        PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Panel ID="ErrorMessage" runat="server">
            </asp:Panel>
            <div class="navigation">
                <asp:LinkButton ID="NextButton" runat="server">&nbsp;</asp:LinkButton>
                <asp:LinkButton ID="PreviousButton" runat="server">&nbsp;</asp:LinkButton>
            </div>
        </div>
    </ItemTemplate>
    <EmptyDataTemplate>
        No data returned</EmptyDataTemplate>
    <EmptyItemTemplate>
        No items returned</EmptyItemTemplate>
</asp:ListView>
<asp:HiddenField ID="CategoriesCount" runat="server" />
<asp:SqlDataSource ID="SqlCategories" OnSelected="SqlCategories_Selected" runat="server"
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" SelectCommand="SELECT [CategoryID], [CategoryText],[Locale], [TargetedCountry] FROM [ATC_PolicyProfiler_Categories] WHERE (([Locale] = @Locale) AND ([TargetedCountry] = @TargetedCountry))"
    InsertCommand="INSERT INTO [ATC_PolicyProfiler_AnsweredQuestionnaires] ([ModuleID], [QuestionnaireID], [QuestionID], [Locale], [TargetedCountry], [AnswerID], [AnsweredByUser], [AnonymousGuid], [AnsweredOnDate], [Rating]) VALUES (@ModuleID, @QuestionnaireID, @QuestionID, @Locale, @TargetedCountry, @AnswerID, @AnsweredByUser, @AnonymousGuid, @AnsweredOnDate, @Rating)">
    <SelectParameters>
        <asp:Parameter Name="Locale" Type="String" />
        <asp:Parameter Name="TargetedCountry" Type="String" />
    </SelectParameters>
    <InsertParameters>
        <asp:Parameter Name="ModuleID" Type="Int32" />
        <asp:Parameter Name="QuestionnaireID" Type="String" />
        <asp:Parameter Name="QuestionID" Type="Int32" />
        <asp:Parameter Name="Locale" Type="String" />
        <asp:Parameter Name="TargetedCountry" Type="String" />
        <asp:Parameter Name="AnswerID" Type="Int32" />
        <asp:Parameter Name="AnsweredByUser" Type="Int32" />
        <asp:Parameter Name="AnonymousGuid" Type="String" />
        <asp:Parameter Name="AnsweredOnDate" Type="DateTime" />
        <asp:Parameter Name="Rating" Type="Int32" />
    </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlStakeholders" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
    SelectCommand="SELECT [Id],[Abbr] FROM [ATC_PolicyProfiler_Stakeholders] WHERE (([Country] = @Country)) ORDER BY [Abbr]">
    <SelectParameters>
        <asp:Parameter Name="Country" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlCountries" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
    SelectCommand="SELECT [Country],[Language],[Translation] FROM [ATC_PolicyProfiler_Countries] WHERE (([Language] = @Language)) ORDER BY [Translation]">
    <SelectParameters>
        <asp:Parameter Name="Language" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlCountryNames" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
    SelectCommand="SELECT [value] FROM [Countries] WHERE [Locale] = @Locale  ORDER BY [value]">
    <SelectParameters>
        <asp:Parameter Name="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDemographics" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
    InsertCommand="INSERT INTO [ATC_PolicyProfiler_Demographics] ([userID],[QuestionnaireID], [Question1], [Question2], [Question3], [Question4], [Question5], [Question6], [Question7],[AnsweredOn]) VALUES (@userID,@QuestionnaireID, @Question1, @Question2, @Question3, @Question4, @Question5, @Question6, @Question7, getdate())">
    <InsertParameters>
        <asp:Parameter Name="userID" Type="String" />
        <asp:Parameter Name="Question1" Type="String" />
        <asp:Parameter Name="Question2" Type="String" />
        <asp:Parameter Name="Question3" Type="String" />
        <asp:Parameter Name="Question4" Type="String" />
        <asp:Parameter Name="Question5" Type="String" />
        <asp:Parameter Name="Question6" Type="String" />
        <asp:Parameter Name="Question7" Type="String" />
        <asp:Parameter Name="AnsweredOnDate" Type="DateTime" />
        <asp:Parameter Name="QuestionnaireID" Type="String" />
        <asp:Parameter Name="Rating" Type="Int32" />
    </InsertParameters>
</asp:SqlDataSource>
<asp:HiddenField ID="HiddenQuestions" Value="" runat="server"></asp:HiddenField>
<asp:HiddenField ID="HiddenAnswers" Value="" runat="server"></asp:HiddenField>
<asp:HiddenField ID="HiddenRatings" Value="" runat="server"></asp:HiddenField>
<asp:HiddenField ID="LoadedSaved" Value="" runat="server"></asp:HiddenField>
<asp:HiddenField ID="AnsweredDemogr" Value="" runat="server"></asp:HiddenField>
<asp:HiddenField ID="DEM_birthplace" Value="true" runat="server"></asp:HiddenField>
<asp:HiddenField ID="DEM_livingplace" Value="true" runat="server"></asp:HiddenField>
<asp:HiddenField ID="DEM_age" Value="true" runat="server"></asp:HiddenField>
<asp:HiddenField ID="DEM_sex" Value="true" runat="server"></asp:HiddenField>
<asp:HiddenField ID="DEM_education" Value="true" runat="server"></asp:HiddenField>
<asp:HiddenField ID="DEM_profession" Value="true" runat="server"></asp:HiddenField>
<asp:HiddenField ID="DEM_municipality" Value="true" runat="server"></asp:HiddenField>

<asp:Panel ID="ResultsPanel" runat="server" Visible="False" CssClass="results">
    <asp:Label ID="Resultlabel" runat="server" Text="Label" Visible="false"></asp:Label>
    <div id="feature_list">
        <ul id="tabs">
            <li><a href="javascript:;">
                <asp:Label CssClass="heading" ID="PositionLbl" runat="server" resourcekey="PositionLbl" /></a>
            </li>
            <li><a href="javascript:;">
                <asp:Label CssClass="heading" ID="MatchesLbl" runat="server" resourcekey="Matches" /></a>
            </li>
            <li><a href="javascript:;">
                <asp:Label CssClass="heading" ID="OverviewLbl" runat="server" resourcekey="Overview" /></a>
            </li>
        </ul>
        <ul id="output">
            <li>
                <div id="bubbleChart" style="width: 500px; float: left;">
                    You need to upgrade your Flash Player</div>
                <div class="catSelection">
                    <div class="RefineResults">
                        <asp:Label CssClass="CategoriesLbl" ID="CategoriesLbl" runat="server" resourcekey="CategoriesLbl" />
                    </div>
                    <asp:CheckBoxList ID="checkedCategories" runat="server" Width="191px" Height="290px"
                        DataSourceID="SqlCategories" DataTextField="CategoryText" OnDataBound="checkedCategories_DataBound">
                    </asp:CheckBoxList>
                    <asp:CheckBox ID="showIntStakeholders" CssClass="InterCheck" runat="server" resourcekey="InterStakeholders"
                        Text="International Stakeholders" />
                </div>
            </li>
            <li>
                <div id="barChart" style="width: 500px; float: left;">
                    You need to upgrade your Flash Player</div>
            </li>
            <li>
                <div id="overviewBubbleChart" style="width: 500px; float: left;">
                    You need to upgrade your Flash Player</div>
                <div class="partySelection">
                    <div class="RefineResults">
                        <asp:Label CssClass="StakeholLbl" ID="Label1" runat="server" resourcekey="CountrySelection" />
                    </div>
                    <table width="190px">
                        <tr>
                            <td align="center">
                                <asp:DropDownList ID="CountrySelector" runat="server" OnDataBound="CountrySelector_DataBound"
                                    Width="150px" DataSourceID="SqlCountries" DataTextField="Translation" DataValueField="Country">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </div>
            </li>
        </ul>
        <div id="shareButtons">
            <div id="fb-root">
            </div>
            <span id="Sharetext">Share:</span> <span style="cursor: pointer"><a href="javascript:;"
                onclick='javascript:PostToFacebook("<%=ProfilerResults%>");'>
                <img src="/dnn6/DesktopModules/EuProfiler/icons/share_fb.png" /></a> </span>
            <span class="st_twitter_custom" style="cursor: pointer">&nbsp;&nbsp;&nbsp;&nbsp;<img
                src="/dnn6/DesktopModules/EuProfiler/icons/share_tw.png" />
            </span><span class="st_linkedin_custom" style="cursor: pointer">&nbsp;&nbsp;&nbsp;&nbsp;<img
                src="/dnn6/DesktopModules/EuProfiler/icons/share_ln.png" />
            </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div id="SummaryActions1">
            <asp:LinkButton ID="SaveButton" runat="server" OnClientClick="return AllowSaveResults()"
                OnClick="SaveButton_Click">&nbsp;</asp:LinkButton>
            <asp:LinkButton ID="ClearButton" runat="server" OnClick="ClearButton_Click">&nbsp;</asp:LinkButton>
        </div>
        <div id="SummaryActions2">
            <asp:HyperLink ID="FeedbackButton" runat="server">&nbsp;</asp:HyperLink>
        </div>
    </div>
</asp:Panel>

<script type="text/javascript">

    var pages = jQuery('div[id^="question"]').length;
    var shares = 0;

    jQuery(document).ready(function() {

        //Fix css of first and last answer buttons
        jQuery('.answers').find('li:first div:first').removeClass('outer').addClass('outerfirst');
        jQuery('.answers').find('li:last div:first').removeClass('outer').addClass('outerlast');
        jQuery('.answers').find('li:last div:last').removeClass('menu_sep outerlast');

        /*************************************  Click Handlers   ********************************/

        /* Click handler for the Start button */
        jQuery('a[id$="StartButton"]').click(function(e) {
            
            jQuery('div[id$="IntroPanel"]').hide();
            var firstCatID = FindIdByOffset(jQuery('div[id^="cat-"]:first'), 4);
            startCategory(firstCatID);
            jQuery('a[id$="PreviousButton"]').hide();
            page = 1;
            updateMeter(-1, 100 / pages);
            jQuery('#<%= HomeLink.ClientID %>').removeClass('selected');
            jQuery('#<%= IssuesLink.ClientID %>').addClass('selected');

            //_gaq.push(['_trackEvent', 'Policy Profiler', 'Click', 'Start Button']);
            return false;
        });

        /* Click handler for the Clear menu item */
        jQuery('#<%= ClearButton.ClientID %>').dnnConfirm({
            text: '<%= Localization.GetString("restart.Text", LocalResourceFile) %>',
            yesText: '<%= Localization.GetString("yes.Text", LocalResourceFile)%>',
            noText: '<%= Localization.GetString("no.Text", LocalResourceFile)%>',
            title: '<%= Localization.GetString("restartTitle.Text", LocalResourceFile)%>?'
        });

        /* Click handler for the Issues menu item */
        jQuery('#<%= IssuesLink.ClientID %>').click(function(e) {

            jQuery('#<%= IssuesLink.ClientID %>').addClass('selected');
            jQuery('#<%= HomeLink.ClientID %>').removeClass('selected');
            jQuery('#<%= ResultsLink.ClientID %>').removeClass('selected');

            HideAll();

            /* if the user has allready answered the questionnaire
            * we show the summary page
            */
            var answers = '<%=Session["LoadedSaved"]%>';
            if (answers != "") {
                gotoSummary();
            }
            /*else we show first category questions  */
            else {
                var firstCatID = FindIdByOffset(jQuery('div[id^="cat-"]:first'), 4);
                startCategory(firstCatID);
                jQuery('a[id$="PreviousButton"]').hide();
                jQuery('.navigation').show();
                page = 1;
                updateMeter(-1, 100 / pages);
            }
            //_gaq.push(['_trackEvent', 'Policy Profiler', 'Click', 'Issues Button']);
            return false;
        });

        /* Click handler for the Home menu item */
        jQuery('#<%= HomeLink.ClientID %>').click(function(e) {
            jQuery('#<%= HomeLink.ClientID %>').addClass('selected');
            jQuery('#<%= IssuesLink.ClientID %>').removeClass('selected');
            jQuery('#<%= ResultsLink.ClientID %>').removeClass('selected');
            ClearAll();

            //_gaq.push(['_trackEvent', 'Policy Profiler', 'Click', 'Home Button']);
            return false;
        });

        /* Click handler for the Demographics button 
        * If the user is registered and has answered the demographics 
        * questionnaire we go directly to the results
        */
        jQuery('a[id$="DemographicsBtn"]').click(function(e) {

            var answered = "<%=AnsweredDemogr.Value%>";
            if (answered == "true") {
                completeQuestionnaire();
            }
            else {
                jQuery(this).addClass('selected');
                jQuery('#<%= HomeLink.ClientID %>').removeClass('selected');
                jQuery('#<%= IssuesLink.ClientID %>').removeClass('selected');
                jQuery('#<%= ResultsLink.ClientID %>').removeClass('selected');

                HideAll();

                jQuery('#demographicsScreen').show();
                return false;
            }
        });

        /* Check if we are in Spanish and hide the relevant questions in the demographics section */
        var culture = "<%=System.Threading.Thread.CurrentThread.CurrentCulture.Name %>";
        if (culture != "es-ES") {
            jQuery('.Spanish').hide();
        }

        /*******************************************  Navigation   *******************************/

        /* Next button click handler. Shows next questions of category or the next category */
        jQuery('a.nextBtn').click(function(e) {

            var currentCatID = FindIdByOffset(jQuery('.questionContainer:visible').parent(), 4);
            var currentQuestion = jQuery('#cat-' + currentCatID + ' .questionContainer:visible');
            var currentQuesId = FindIdByOffset(jQuery("#cat-" + currentCatID + ' .questionContainer:visible:first'), 8);
            var nextQuestionCatID = FindIdByOffset(jQuery("#question" + (currentQuesId + 1)).parent(), 4);

            if (!checkAnswered(currentQuesId)) {
                jQuery('.errorMessage').show();
                state = 1;
            }
            // else if there's no other category we go to the summary screen
            else if (nextQuestionCatID == -1) {
                jQuery(' div[id^="cat-"]').hide();
                jQuery("#question" + currentQuesId).hide();
                gotoSummary();
                //_gaq.push(['_trackEvent', 'Policy Profiler', 'Click', 'Question ' + currentQuesId]);
            }
            // If the category (.parent()) of the next question is the same we show the next question
            else if (nextQuestionCatID == currentCatID) {
                jQuery("#question" + currentQuesId).hide();
                jQuery("#question" + (currentQuesId + 1)).show();
                jQuery('a[id$="PreviousButton"]').show();
                jQuery('.errorMessage').hide();
                page++;
                updateMeter(parseInt(((100 / pages) * (page - 1))), parseInt(((100 / pages) * page)));
                //_gaq.push(['_trackEvent', 'Policy Profiler', 'Click', 'Question ' + currentQuesId]);
            }
            // else we start with the next category
            else {
                startCategory(currentCatID + 1);
                jQuery('a[id$="PreviousButton"]').show();
                jQuery('.error').hide();
                page++;
                updateMeter(parseInt(((100 / pages) * (page - 1))), parseInt(((100 / pages) * page)));
                //_gaq.push(['_trackEvent', 'Policy Profiler', 'Click', 'Question ' + currentQuesId]);
            }
            return false;
        });


        //Go to previous category
        jQuery('a.previousBtn').click(function(e) {

            var currentCatID = FindIdByOffset(jQuery('.questionContainer:visible').parent(), 4);
            var prevCatID = currentCatID - 1;

            // We find the id of the first question of the category and the id of the first visible question
            var firstQuesId = FindIdByOffset(jQuery("#cat-" + currentCatID + ' .questionContainer:first'), 8);
            var quesId = FindIdByOffset(jQuery("#cat-" + currentCatID + ' .questionContainer:visible:first'), 8);

            // If they are not the same we just go back to questions of the same category
            if (quesId != firstQuesId) {
                jQuery("#question" + quesId).hide();
                jQuery("#question" + (quesId - 1)).show();
                page--;
                updateMeter(parseInt(((100 / pages) * (page - 1))), parseInt(((100 / pages) * page)));
                // If we go back to the first question of the questionnaire we should hide the back button
                if (quesId == 2)
                    jQuery('a[id$="PreviousButton"]').hide();
            }
            // Else the first questions of the current category are displayed
            // so 'previous' has to take us to the last question(s) of the previous category
            else {
                jQuery("#cat-" + currentCatID).hide();
                jQuery("#cat-" + (currentCatID - 1)).show();
                page--;
                updateMeter(parseInt(((100 / pages) * (page - 1))), parseInt(((100 / pages) * page)));
            }
            jQuery('.error').hide();
            return false;
        });

        /* Show the first question of a category 
        @integer catID the id of the div*/
        function startCategory(catID) {
            jQuery(' div[id^="cat-"]').hide();
            jQuery('#cat-' + catID).show();
            jQuery('#cat-' + catID + ' .questionContainer:first').show();
        }

        // Add star rating to each question
        jQuery.each(jQuery('div[id^="question"]'), function() {
            var currentQuestionId = FindIdByOffset(jQuery(this), 8);
            jQuery('#stars-wrapper' + currentQuestionId).stars({
                captionEl: jQuery('#stars-cap' + currentQuestionId)
            });
        });

        /* Highlight the clicked answer button */
        jQuery('.answers > li > .outer > a,.answers > li > .outerfirst > a,.answers > li > .outerlast > a')
        .click(function(e) {
            jQuery('#' + jQuery(this).parents('.questionContainer').attr('id') + ' .answers > li').removeClass('active');
            jQuery(this).parents('li').addClass('active');
            jQuery('.error').hide(); // hide error if visible;
            return false;
        });

        /* List results charts as vertical tabs   */
        jQuery.featureList(
				jQuery("#tabs li a"),
				jQuery("#output li"), {
				    start_item: 0,
				    transition_interval: -1  // No automatic transition
				}
			);

        loadSavedQuestionnaire();

        /* Show/Hide the udebate link on a left sidebar */
        jQuery(".trigger").click(function() {
            jQuery(".uDebateLinkDiv").toggle("slow");
            jQuery(this).toggleClass("active");
            //_gaq.push(['_trackEvent', 'Policy Profiler', 'Click', 'u-Debate sidebar']);
            return false;
        });
    });                   /* End of document ready function */


    /********************************** Summary, Demographics, Finish ***************************/

    /* Displays answers in the final screen when questionnaire is completed */
    function gotoSummary() {
        var answers = jQuery('.answers > li.active a');
        var answerOptions = jQuery('#question1 li a span'); // The answer options in the selected language
        var answersArray = new Array();
        var currentQuestionId = '';
        var summaryList = '<div id="scroll-pane" style="overflow: hidden;">' +
	                      '<div id="scroll-content">';

        jQuery.each(answers, function(index) {

            currentQuestionId = FindIdByOffset(jQuery(this).parents('.questionContainer'), 8);
            answersArray[index] = jQuery(this).attr('href');

            /* 
            *  Fill the summary list with the questions and the respective answers
            */
            summaryList += "<div class='summaryLine'><div class='summaryQuestion'>" +
                                jQuery('#question' + currentQuestionId + ' .question').html().trim() +
                          "</div>"
            // Selected values will be set later on when the DOM is ready
                        + " <div class='summaryAnswer' id=\"dropdown" + currentQuestionId + "\"> " +
	                    " <select> " +
		                "<option value='1'>" + jQuery(answerOptions[0]).html() + "</option>" +
		            	"<option value='2'>" + jQuery(answerOptions[1]).html() + "</option>" +
		            	"<option value='3'>" + jQuery(answerOptions[2]).html() + "</option>" +
		            	"<option value='4'>" + jQuery(answerOptions[3]).html() + "</option>" +
		            	"<option value='5'>" + jQuery(answerOptions[4]).html() + "</option>" +
		            	"<option value='6'>" + jQuery(answerOptions[5]).html() + "</option>" +
			            "</select></div>" +

                        "<div class='summaryRating'>" +
                        "<div id='stars-wrapper-Summary" + currentQuestionId + "' class='summaryStars'>" +
                        " <input type='radio' name='quesrate' value='1' title='Less important' />" +
                        " <input type='radio' name='quesrate' value='1' title='Normal' />" +
                        " <input type='radio' name='quesrate' value='1' title='Very important' />" +
                        "</div></div></div>";
        });
        summaryList += '</div></div>';
        jQuery('#summaryList').html(summaryList);
        jQuery('#summaryScreen').show();
        jQuery('#<%= ResultsLink.ClientID %>').attr('onclick', 'return false');
        jQuery('#<%= ResultsLink.ClientID %>').attr('href', '#');

        // Add selected star rating to each question
        var selectedRating = 0;
        jQuery.each(jQuery('div[id^="stars-wrapper-Summary"]'), function() {
            var currentQuesSummaryId = FindIdByOffset(jQuery(this), 21);
            jQuery(this).stars({
                disabled: true
            });
            selectedRating = jQuery("#stars-wrapper" + currentQuesSummaryId).data("stars").options.value;
            jQuery(this).stars("selectID", selectedRating - 1);

            /* We set the selected answer of the dropdown list here, becaue the select
            element have been loaded to the DMO
            We need currentQuesSummaryId-1 because questions start from 1 and not 0  <---- big PITA
            */
            jQuery('#dropdown' + currentQuesSummaryId + ' > select').val(answersArray[currentQuesSummaryId - 1]);
        });
        fixScrolledSummary();
    }

    /* The scroller in the summary page */
    function fixScrolledSummary() {
        //change the main div to overflow-hidden as we can use the slider now
        jQuery('#scroll-pane').css('overflow', 'hidden');

        //compare the height of the scroll content to the scroll pane to see if we need a scrollbar
        var difference = jQuery('#scroll-content').height() - jQuery('#scroll-pane').height();
        if (difference > 0) {
            var proportion = difference / jQuery('#scroll-content').height();
            var handleHeight = Math.round((1 - proportion) * jQuery('#scroll-pane').height()); //set the proportional height - round it to make sure everything adds up correctly later on
            handleHeight -= handleHeight % 2;

            jQuery("#scroll-pane").after('<\div id="slider-wrap"><\div id="slider-vertical"><\/div><\/div>'); //append the necessary divs so they're only there if needed
            jQuery("#slider-wrap").height(jQuery("#scroll-pane").height()); //set the height of the slider bar to that of the scroll pane

            //set up the slider
            jQuery('#slider-vertical').slider({
                orientation: 'vertical',
                min: 0,
                max: 100,
                value: 100,
                slide: function(event, ui) {//used so the content scrolls when the slider is dragged
                    var topValue = -((100 - ui.value) * difference / 100);
                    jQuery('#scroll-content').css({ top: topValue }); //move the top up (negative value) by the percentage the slider has been moved times the difference in height
                },
                change: function(event, ui) {//used so the content scrolls when the slider is changed by a click outside the handle or by the mousewheel
                    var topValue = -((100 - ui.value) * difference / 100);
                    jQuery('#scroll-content').css({ top: topValue }); //move the top up (negative value) by the percentage the slider has been moved times the difference in height
                }
            });

            //set the handle height and bottom margin so the middle of the handle is in line with the slider
            jQuery(".ui-slider-handle").css({ height: handleHeight, 'margin-bottom': -0.5 * handleHeight });
            jQuery(".ui-slider-handle").append('<div id="scrollbar-top"></div> ');
            jQuery(".ui-slider-handle").append('<div id="scrollbar-bottom"></div>');

            var origSliderHeight = jQuery("#slider-vertical").height(); //read the original slider height
            var sliderHeight = origSliderHeight - handleHeight; //the height through which the handle can move needs to be the original height minus the handle height
            var sliderMargin = (origSliderHeight - sliderHeight) * 0.5; //so the slider needs to have both top and bottom margins equal to half the difference
            jQuery(".ui-slider").css({ height: sliderHeight, 'margin-top': sliderMargin });
        }

        //code to handle clicks outside the slider handle
        jQuery(".ui-slider").click(function(event) {//stop any clicks on the slider propagating through to the code below
            event.stopPropagation();
        });

        jQuery("#slider-wrap").click(function(event) {//clicks on the wrap outside the slider range
            var offsetTop = jQuery(this).offset().top;
            var clickValue = (event.pageY - offsetTop) * 100 / $(this).height();
            jQuery("#slider-vertical").slider("value", 100 - clickValue);
        });

        //additional code for mousewheel
        jQuery("#scroll-pane,#slider-wrap").mousewheel(function(event, delta) {
            var speed = 5;
            var sliderVal = jQuery("#slider-vertical").slider("value");
            sliderVal += (delta * speed);
            jQuery("#slider-vertical").slider("value", sliderVal);
            event.preventDefault();
        });
    }


    /* Loads the answers in hidden fields when questionnaire is completed 
    * in order to pass them to the code behind handler
    */
    function completeQuestionnaire() {

        var answers = jQuery('.answers > li.active a');
        var questionsString = '';
        var answersString = '';
        var ratingsString = '';
        var currentQuestionId = '';
        var currentAnswer = '';
        var currentRating = '';

        /* Initialise hidden fields to empty.
        * Required because the function is re-called when changing answer from summary screen 
        */
        jQuery('input[id$="HiddenQuestions"]').val('');
        jQuery('input[id$="HiddenAnswers"]').val('');
        jQuery('input[id$="HiddenRatings"]').val('');

        jQuery.each(answers, function(index) {

            /* Store answers and ratings of every question in the relevant hidden fields
            * so as to be read by the code-behind function 'FinishButton_Click'
            */
            currentQuestionId = FindIdByOffset(jQuery(this).parents('.questionContainer'), 8);
            currentAnswer = jQuery('#dropdown' + currentQuestionId + ' > select').val();
            currentRating = jQuery("#stars-wrapper" + currentQuestionId).data("stars").options.value;

            // Check if hidden fields have no value 
            if (typeof (jQuery('input[id$="HiddenAnswers"]').val()) != 'undefined') {
                questionsString = jQuery('input[id$="HiddenQuestions"]').val();
                answersString = jQuery('input[id$="HiddenAnswers"]').val();
                ratingsString = jQuery('input[id$="HiddenRatings"]').val();
            }
            jQuery('input[id$="HiddenQuestions"]').val(questionsString + currentQuestionId + '--');
            jQuery('input[id$="HiddenAnswers"]').val(answersString + currentAnswer + '--');
            jQuery('input[id$="HiddenRatings"]').val(ratingsString + currentRating + '--');
        });

        //_gaq.push(['_trackEvent', 'Policy Profiler', 'Click', 'Finish questionnaire']);
    }

    /* Loads the answers of the Demographics questions in hidden fields 
    * in order to pass them to the code behind handler
    */
    function completeDemographics() {

        /* Initialise hidden fields to empty.
        */
        jQuery('input[id$="DEM_birthplace"]').val('');
        jQuery('input[id$="DEM_livingplace"]').val('');
        jQuery('input[id$="DEM_age"]').val('');
        jQuery('input[id$="DEM_sex"]').val('');
        jQuery('input[id$="DEM_education"]').val('');
        jQuery('input[id$="DEM_profession"]').val('');
        jQuery('input[id$="DEM_municipality"]').val('');

        /* Store answers and ratings of every question in the relevant hidden fields
        * so as to be read by the code-behind function 'FinishButton_Click'
        */

        jQuery('input[id$="DEM_birthplace"]').val(jQuery('select[id$="BirthPlaceDropD"] :selected').text());
        jQuery('input[id$="DEM_livingplace"]').val(jQuery('select[id$="LivingPlaceDropD"] :selected').text());
        jQuery('input[id$="DEM_age"]').val(jQuery('select[id$="ageDropD"] :selected').text());
        if (jQuery('input[value$="Male"]').is(':checked')) {
            jQuery('input[id$="DEM_sex"]').val('Male');
        }
        if (jQuery('input[value$="Female"]').is(':checked')) {
            jQuery('input[id$="DEM_sex"]').val('Female');
        }
        jQuery('input[id$="DEM_education"]').val(jQuery('select[id$="EducationDropD"] :selected').val());
        jQuery('input[id$="DEM_profession"]').val(jQuery('select[id$="occupationDropD"] :selected').val());        
        
        jQuery('input[id$="DEM_municipality"]').val(jQuery('input[id$="MunicipalityText"]').val());

        /* We finished with demographics questionnaire,
        * so we now load the answers of the questionnaire 
        */
        /*alert('<%= Localization.GetString("DemogrThanks.Text", LocalResourceFile) %>');*/
        completeQuestionnaire();

        //_gaq.push(['_trackEvent', 'Policy Profiler', 'Click', 'Finish questionnaire']);
    }


    /* Load the answers of the user in the following cases
    *
    * If User is Logged in and he has previously saved answers 
    * If the page is reloaded after the user has finished the questionnaire
    *
    */
    function loadSavedQuestionnaire() {

        var answers = '<%=Session["LoadedSaved"]%>';
        if (answers != "") {
            var answerArray = answers.split("--");
            var questions = jQuery('.questionContainer');

            jQuery.each(questions, function(index) {
                jQuery(this).find('.answers > li').eq(answerArray[index] - 1).addClass('active');
            });
             
            if (!jQuery('#<%= ResultsLink.ClientID %>').hasClass('selected'))
                showResultsMessage('summary');
        }       
    }


    /************************************** Chart updating *****************************/


    /* Update the overview bubble diagram */
    jQuery('select[id$="CountrySelector"]').change(function(e) {
        var country = "all";
        switch (jQuery(this).find(':selected').val()) {
            case "Greece": country = "el-GR"; break;
            case "Italy": country = "it-IT"; break;
            case "Hungary": country = "hu-HU"; break;
            case "Spain": country = "es-ES"; break;
            case "All": country = "all"; break;
            default: country = "all";
        }
        amOverviewbubbleChanged('amOverviewbubble', country);
        return false;
    });

    /* Update the bubble chart 
    * The checked categories are passed as an array
    *    
    */
    jQuery('input[id*="checkedCategories_"]').change(function(e) {

        var checkedCheckboxes = new Array();
        jQuery('input[id*="checkedCategories_"]').each(function(index) {
            if (jQuery(this).attr('checked') == 'checked')
            { checkedCheckboxes.push(1); }
            else
            { checkedCheckboxes.push(0); }
        });

        /* The checkbox to see if international stakeholders will be included */
        if (jQuery('input[id$="showIntStakeholders"]').attr('checked') == 'checked')
        { checkedCheckboxes.push(1); }
        else
        { checkedCheckboxes.push(0); }

        amBubbleChanged('ambubble', checkedCheckboxes);
        return false;
    });

    /* Update the bubble chart 
    * when international checkbox is changed 
    */
    jQuery('input[id$="showIntStakeholders"]').change(function(e) {

        var checkedCheckboxes = new Array();
        jQuery('input[id*="checkedCategories_"]').each(function(index) {
            if (jQuery(this).attr('checked') == 'checked')
            { checkedCheckboxes.push(1); }
            else
            { checkedCheckboxes.push(0); }
        });

        /* The checkbox to see if international stakeholders will be included */
        if (jQuery('input[id$="showIntStakeholders"]').attr('checked') == 'checked')
        { checkedCheckboxes.push(1); }
        else
        { checkedCheckboxes.push(0); }

        amBubbleChanged('ambubble', checkedCheckboxes);
        return false;
    });


    /************************************** Auxiliary functions *****************************/

    /* Update the completion meter  */
    function updateMeter(beginFrom, progressBarLimit) {

        if (progressBarLimit > 100) {
            progressBarLimit = 100;
        }
        var count = beginFrom;
        var inter = null;
        inter = setInterval(run, 20);

        function run() {
            count++;
            jQuery('.meter-wrap').find('.meter-value').css('width', count + "%");
            if (count >= Math.round(progressBarLimit)) {
                clearInterval(inter);
            }
            var language = "<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>";
            if (language == 'el-GR')
                jQuery('.meter-text').html(count + "%" + ' Ολοκληρωμένο');
            else if (language == 'es-ES')
                jQuery('.meter-text').html(count + "%" + ' Cumplimentado');
            else if (language == 'it-IT')
                jQuery('.meter-text').html(count + "%" + ' Completato');
            else if (language == 'hu-HU')
                jQuery('.meter-text').html(count + "%" + ' Kész');
            else // english
                jQuery('.meter-text').html(count + "%" + ' Complete');
        }
    }

    /* Check if the given question has been answered */
    function checkAnswered(questionId) {

        answered = jQuery('#question' + questionId).find('.answers > li.active');
        if (answered.size() != 1)
            return false;
        else
            return true;
    }

    /* Returns the id as an integer, by reading the 'id' attribute
    of the given object starting from the specified offset.
    e.g cat-1     : offset = 4
    question5 : offset = 8   
    next-4    : offset = 5 
    previous-2: offset = 9     
    */
    function FindIdByOffset(categoryObj, offset) {

        if (typeof (categoryObj.attr('id')) != 'undefined')
            return parseInt(categoryObj.attr('id').substring(offset));
        else
            return -1;
    }

    function showResultsMessage(show) {
        if (show == "true") {
            jQuery('.dnnFormInfo').show().delay(7392).fadeOut();
            return false;
        }
        else if (show == "false") {
            jQuery('.dnnFormInfo').hide();
            jQuery('div[id$="questionnaire"]').hide();
            jQuery('#<%= ResultsPanel.ClientID %>').show();
            jQuery('#<%= ResultsLink.ClientID %>').addClass('selected');
            jQuery('#<%= IssuesLink.ClientID %>').removeClass('selected');
            jQuery('#<%= HomeLink.ClientID %>').removeClass('selected');
            return false;
        }
        else if (show == 'summary') {
            jQuery(' div[id^="cat-"]').hide();
            jQuery('div[id$="IntroPanel"]').hide();
            gotoSummary();
        }
        else//do nothing
        {
            return false;
        }
    }

    /* Check if user is allowed to save his answers*/
    function AllowSaveResults() {

        var isAuthenticated = "<%= Request.IsAuthenticated %>";

        if (isAuthenticated == "False") {
            jQuery.dnnAlert({
                text: '<%= Localization.GetString("LoggedinSave.Text", LocalResourceFile) %>',
                okText: 'OK'
            });
            //_gaq.push(['_trackEvent', 'Policy Profiler', 'Save', 'Not Allowed']);
            return false;
        }
        else {
            //_gaq.push(['_trackEvent', 'Policy Profiler', 'Save', 'Successfull']);
            return true;
        }
    }

    /* Hide all divs */
    function HideAll() {
        jQuery('div[id^="cat-"]').hide();
        jQuery('div[id^="question"]').hide();
        jQuery('#summaryScreen').hide();
        jQuery('.SummaryButton').hide();
        jQuery('div[id$="IntroPanel"]').hide();
        jQuery('.errorMessage').hide();
        jQuery('#demographicsScreen').hide();
        jQuery('div[id$= "ResultsPanel"]').hide();
        jQuery('div[id$=questionnaire]').show();
    };

    /* Clears all the answers and starts a blank questionnaire */
    function ClearAll() {

        //jQuery('.answers > li.active').removeClass('active');       
        HideAll();
        jQuery('input[id$="HiddenQuestions"]').val('');
        jQuery('input[id$="HiddenAnswers"]').val('');
        jQuery('input[id$="HiddenRatings"]').val('');

        jQuery('div[id$="IntroPanel"]').show();
        return false;
    };

    function FacebookInit() {
        // Initialise facebook api
        FB.init({
            appId: '274597442564126', // App ID
            channelURL: 'http://join.puzzledbypolicy.eu', // Channel File
            status: false, // check login status
            cookie: true, // enable cookies to allow the server to access the session
            oauth: true, // enable OAuth 2.0
            xfbml: true  // parse XFBML
        });
    }

    function PostToFacebook(results) {
        if (shares == 0) {
            FacebookInit();
        }
        shares = 1;
        FB.ui(
            {
                method: 'feed',
                name: '<%= Localization.GetString("fb_share_title_home.Text", LocalResourceFile) %>',
                link: 'http://join.puzzledbypolicy.eu/policyprofiler.aspx',
                picture: 'http://join.puzzledbypolicy.eu/Portals/_default/Skins/pbp/images/pbp_logo1.png',
                caption: 'Puzzled By Policy EU',
                description: '<%= Localization.GetString("Share_text_results.Text", LocalResourceFile) %>' + results
            },
            function(response) {
                if (response && response.post_id) {
                   // _gaq.push(['_trackEvent', 'Policy Profiler', 'Share', 'Shared to Facebook']);
                } else {
                    // alert('Your post was not published.');
                }
            }
            );
    }    
</script>

<script type="text/javascript">
    // The code to add the charts

    // <![CDATA[
    var barChart = new SWFObject("/dnn6/DesktopModules/EuProfiler/js/ammap/amcolumn.swf", "ambar", "500", "400", "8", "#FFFFFF");
    barChart.addVariable("path", "/dnn6/DesktopModules/EuProfiler/js/ammap/");
    barChart.addVariable("settings_file", escape("http://" + location.hostname +
                             "/dnn6/DesktopModules/EuProfiler/Components/BarSettings7_<%=System.Threading.Thread.CurrentThread.CurrentCulture.Name %>.xml"));
    barChart.addVariable("data_file", escape("http://" + location.hostname +
                           "/dnn6/PProfilerResults/BarChartData.aspx?questions=" +
                           jQuery('input[id$="HiddenQuestions"]').val() + "&answers=" +
                           jQuery('input[id$="HiddenAnswers"]').val() + "&ratings=" +
                           jQuery('input[id$="HiddenRatings"]').val() + "&culture=" +
                           "<%=System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&locale=<%=targetCountry %>"));
    barChart.addParam("wmode", "transparent");
    barChart.write("barChart");
    // ]]>

    // <![CDATA[
    var bubbleChart = new SWFObject("/dnn6/DesktopModules/EuProfiler/js/ammap/amxy.swf", "ambubble", "500", "400", "8", "#FFFFFF");
    bubbleChart.addVariable("path", "/dnn6/DesktopModules/EuProfiler/js/ammap/");
    bubbleChart.addVariable("settings_file", escape("http://" + location.hostname +
                             "/dnn6/DesktopModules/EuProfiler/Components/BubbleSettings_<%=System.Threading.Thread.CurrentThread.CurrentCulture.Name %>.xml"));
    bubbleChart.addVariable("data_file", escape("http://" + location.hostname +
                           "/dnn6/PProfilerResults/BubbleChartData.aspx?questions=" +
                           jQuery('input[id$="HiddenQuestions"]').val() + "&answers=" +
                           jQuery('input[id$="HiddenAnswers"]').val() + "&ratings=" +
                           jQuery('input[id$="HiddenRatings"]').val() + "&cat=all&inter=0&overview=1&culture=" +
                           "<%=System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&locale=<%=targetCountry %>"));
    bubbleChart.addParam("wmode", "transparent");
    bubbleChart.write("bubbleChart");
    // ]]>

    // <![CDATA[
    var overViewBubbleChart = new SWFObject("/dnn6/DesktopModules/EuProfiler/js/ammap/amxy.swf", "amOverviewbubble", "500", "400", "8", "#FFFFFF");
    overViewBubbleChart.addVariable("path", "/dnn6/DesktopModules/EuProfiler/js/ammap/");
    overViewBubbleChart.addVariable("settings_file", escape("http://" + location.hostname +
                             "/dnn6/DesktopModules/EuProfiler/Components/BubbleSettings_<%=System.Threading.Thread.CurrentThread.CurrentCulture.Name %>.xml"));
    overViewBubbleChart.addVariable("data_file", escape("http://" + location.hostname +
                           "/dnn6/PProfilerResults/OverviewBubbleChartData.aspx?questions=" +
                           jQuery('input[id$="HiddenQuestions"]').val() + "&answers=" +
                           jQuery('input[id$="HiddenAnswers"]').val() + "&ratings=" +
                           jQuery('input[id$="HiddenRatings"]').val() + "&cat=all" +
                           "&culture=<%=System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&country=all"));
    overViewBubbleChart.addParam("wmode", "transparent");
    overViewBubbleChart.write("overviewBubbleChart");
    // ]]>
	
</script>

<script type="text/javascript">



    function amBubbleChanged(chart_id, checkedCheckboxes) {
        flashMovie = document.getElementById(chart_id);
        flashMovie.reloadData(escape("http://" + location.hostname +
                           "/dnn6/PProfilerResults/BubbleChartData.aspx?questions=" +
                           jQuery('input[id$="HiddenQuestions"]').val() + "&answers=" +
                           jQuery('input[id$="HiddenAnswers"]').val() + "&ratings=" +
                           jQuery('input[id$="HiddenRatings"]').val() +
                           "&cat1=" + checkedCheckboxes[0] + "&cat2=" + checkedCheckboxes[1] +
                           "&cat3=" + checkedCheckboxes[2] + "&cat4=" + checkedCheckboxes[3] +
                           "&cat5=" + checkedCheckboxes[4] + "&inter=" + checkedCheckboxes[5] +
                           "&overview=0&culture=<%=System.Threading.Thread.CurrentThread.CurrentCulture.Name%>" +
                           "&locale=<%=targetCountry %>"));
    }

    function amOverviewbubbleChanged(chart_id, country) {
        flashMovie = document.getElementById(chart_id);
        flashMovie.reloadData(escape("http://" + location.hostname +
                           "/dnn6/PProfilerResults/OverviewBubbleChartData.aspx?questions=" +
                           jQuery('input[id$="HiddenQuestions"]').val() + "&answers=" +
                           jQuery('input[id$="HiddenAnswers"]').val() + "&ratings=" +
                           jQuery('input[id$="HiddenRatings"]').val() +
                           "&cat=all&culture=<%=System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&country=" + country));
    }
</script>

<script type="text/javascript" src="//connect.facebook.net/en_US/all.js"></script>

<script type="text/javascript" src="http://w.sharethis.com/button/buttons.js"></script>

<script type="text/javascript">
    stLight.options({
        publisher: '6047b465-24ec-45c1-ad8b-d5c16f397045'
    });
</script>

