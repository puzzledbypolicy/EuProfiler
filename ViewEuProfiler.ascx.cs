using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Modules.Actions;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Services.Localization;

using System.Web;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;
using System.Net;
using System.Xml.XPath;
using System.IO;
using System.Xml;
using System.Configuration;

namespace ATC.Modules.EuProfiler
{
    public partial class ViewEuProfiler : PortalModuleBase, IActionable
    {
        public string targetCountry = "EU";
        public string ProfilerResults = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            /*  ATTENTION: The demographics pages must have a localised value in the
             * description meta tag. this is what gets displayed as a title of the 
             * popup window. This has been changed in <site-home>/js/dnn.modalpopup.js             * 
             */

            //showDemographics.OnClientClick = "return " +
            //UrlUtils.PopUpUrl("/" + System.Threading.Thread.CurrentThread.CurrentCulture.Name
            //+ "/demographics.aspx", this, PortalSettings, true, false, 380, 420, false, "");

            /* If we have a postback, the user has finished the questionnary 
             * and we must show him the results
             */
            if (IsPostBack)
            {
                /* Check if this postback is after the finish of the questionnaire
                 * and if yes, show the results, adjust the menu links
                 * and keep the answers so as to be selected in the reloaded questionnaire
                 */
                if (!HiddenQuestions.Value.Equals(""))
                {
                    CategoriesDataList.Style.Add(HtmlTextWriterStyle.Display, "none");
                    HtmlGenericControl qu = (HtmlGenericControl)CategoriesDataList.FindControl("questionnaire");
                    qu.Style.Add(HtmlTextWriterStyle.Display, "none");
                    ResultsPanel.Visible = true;
                    ResultsLink.Attributes.Remove("OnClick");
                    ResultsLink.CssClass = "selected";
                    HomeLink.CssClass = "";
                    ResultsLink.Attributes.Add("OnClick", "return showResultsMessage('false');");

                    //                    if (showDemographicsPopup.Value == "true")
                    //                    {
                    //                        /* Show the demographics popup*/
                    //                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "jQueryCode",
                    //                           @"jQuery(document).ready(function() {jQuery('a[id$=""showDemographics\""]').click();
                    //          	        });", true);
                    //                    }

                    /* keep the selected answers in session*/
                    Session["LoadedSaved"] = HiddenAnswers.Value;
                    if (Request.IsAuthenticated)
                        AnsweredDemogr.Value = showDemographics();
                }
                else
                {
                    CategoriesDataList.Style.Add(HtmlTextWriterStyle.Display, "block");
                    HtmlGenericControl qu = (HtmlGenericControl)CategoriesDataList.FindControl("questionnaire");
                    qu.Style.Add(HtmlTextWriterStyle.Display, "block");
                    ResultsPanel.Visible = false;
                }

            }

            //Add the JQuery libraries for the UI     
            ScriptReference objScriptReference;
            ScriptManager objScriptManager = ScriptManager.GetCurrent(this.Page);

            objScriptReference = new ScriptReference(@"~/DesktopModules/EuProfiler/js/jquery-ui-1.8.10.min.js");
            objScriptManager.Scripts.Add(objScriptReference);

            objScriptReference = new ScriptReference(@"~/DesktopModules/EuProfiler/js/jquery.ui.stars.min.js");
            objScriptManager.Scripts.Add(objScriptReference);

            objScriptReference = new ScriptReference(@"~/DesktopModules/EuProfiler/js/ammap/swfobject.js");
            objScriptManager.Scripts.Add(objScriptReference);

            objScriptReference = new ScriptReference(@"~/DesktopModules/EuProfiler/js/jquery.mousewheel.min.js");
            objScriptManager.Scripts.Add(objScriptReference);

            objScriptReference = new ScriptReference(@"~/DesktopModules/EuProfiler/js/jquery.featureList-1.0.0.js");
            objScriptManager.Scripts.Add(objScriptReference);

            if (!IsPostBack)
            {
                ResultsLink.Attributes.Add("OnClick", "return showResultsMessage('true');");
                string Culture = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
                SqlCategories.SelectParameters["Locale"].DefaultValue = Culture;

                /*if (Culture.StartsWith("en"))
                {
                    SqlStakeholders.SelectParameters["Country"].DefaultValue = "el-GR";
                    SqlCategories.SelectParameters["TargetedCountry"].DefaultValue = "el-GR";
                    SqlCountries.SelectParameters["Language"].DefaultValue = "en-GB";
                    SqlCountryNames.SelectParameters["Locale"].DefaultValue = "en-GB";
                }
                else
                {*/
                SqlStakeholders.SelectParameters["Country"].DefaultValue = Culture.Equals("en-GB") ? "EU" : Culture;
                SqlCategories.SelectParameters["TargetedCountry"].DefaultValue = Culture;
                SqlCountries.SelectParameters["Language"].DefaultValue = Culture;
                SqlCountryNames.SelectParameters["Locale"].DefaultValue = Culture;
                //}
                if (Request.IsAuthenticated)
                {
                    String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString();
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        String queryString = " SELECT UserAnswers,UserRatings FROM ATC_PolicyProfiler_SavedAnswers " +
                                            " WHERE UserID=" + this.UserId.ToString() + " ORDER BY SavedOnDate DESC";

                        SqlCommand command = new SqlCommand(queryString, connection);
                        command.Connection.Open();
                        String result = (String)command.ExecuteScalar();
                        if (result != null)
                        {
                            Session["LoadedSaved"] = result;
                            ResultsLink.Attributes.Add("OnClick", "return showResultsMessage('summary');");
                        }
                    }
                    AnsweredDemogr.Value = showDemographics();
                }
            }
            LocalResourceFile = Localization.GetResourceFile(this, "ViewEuProfiler.ascx." + System.Threading.Thread.CurrentThread.CurrentCulture.Name + ".resx");
        }

        #region IActionable Members

        public DotNetNuke.Entities.Modules.Actions.ModuleActionCollection ModuleActions
        {
            get
            {
                //create a new action to add an item, this will be added to the controls
                //dropdown menu
                ModuleActionCollection actions = new ModuleActionCollection();
                actions.Add(GetNextActionID(), Localization.GetString(ModuleActionType.AddContent, this.LocalResourceFile),
                    ModuleActionType.AddContent, "", "", EditUrl(), false, DotNetNuke.Security.SecurityAccessLevel.Edit,
                     true, false);

                return actions;
            }
        }

        #endregion

        protected void CategoriesDataList_ItemDatabound(object sender, ListViewItemEventArgs e)
        {
            string Culture = System.Threading.Thread.CurrentThread.CurrentCulture.Name;

            LinkButton start = (LinkButton)CategoriesDataList.FindControl("StartButton");
            LinkButton next = (LinkButton)e.Item.FindControl("NextButton");
            LinkButton previous = (LinkButton)e.Item.FindControl("PreviousButton");
            LinkButton results = (LinkButton)CategoriesDataList.FindControl("FinishBtn");
            LinkButton demogra = (LinkButton)CategoriesDataList.FindControl("DemographicsBtn");
            LinkButton submitdemog = (LinkButton)CategoriesDataList.FindControl("SubmitDemogBtn");
            Panel error = (Panel)e.Item.FindControl("ErrorMessage");

            start.CssClass = "startBtn Btn_" + Culture;
            next.CssClass = "nextBtn nBtn_" + Culture;
            previous.CssClass = "previousBtn prBtn_" + Culture;
            results.CssClass = "resultsBtn rBtn_" + Culture;
            demogra.CssClass = "finishBtn finBtn_" + Culture;
            submitdemog.CssClass = "submitDemogBtn demBtn_" + Culture;
            error.CssClass = "errorMessage erBtn_" + Culture;
        }


        protected void SqlCategories_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            int resultsf = e.AffectedRows;
            CategoriesCount.Value = resultsf.ToString();
        }

        ///*Shows the sql being executed  */
        //protected void SqlDemographics_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        //{
        //    SqlParameterCollection myCollection = (SqlParameterCollection)e.Command.Parameters;

        //    IEnumerator ie = myCollection.GetEnumerator();
        //    string strSQL = string.Empty;
        //    while ((ie.MoveNext()))
        //    {
        //        SqlParameter param = (SqlParameter)ie.Current;
        //        string strValue = string.Empty;
        //        if (param.Value == null)
        //            strValue = "NULL";
        //        else
        //            strValue = param.Value.ToString();

        //        strSQL += param.ParameterName.ToString() + "=" + strValue + "<BR />";
        //    }

        //    Response.Write(strSQL.ToString());
        //}


        protected void FinishButton_Click(object sender, EventArgs e)
        {
            string[] stringSeparators = new string[] { "--" };
            string[] questions = HiddenQuestions.Value.Split(stringSeparators, System.StringSplitOptions.None);
            string[] answers = HiddenAnswers.Value.Split(stringSeparators, System.StringSplitOptions.None);
            string[] ratings = HiddenRatings.Value.Split(stringSeparators, System.StringSplitOptions.None);
            string Culture = System.Threading.Thread.CurrentThread.CurrentCulture.Name;

            DropDownList LanguageSelector = (DropDownList)CategoriesDataList.FindControl("LanguageSelector");
            targetCountry = LanguageSelector.SelectedValue;

            string timestamp = GetTimestamp(System.DateTime.Now);
            string datetime = DateTime.Now.ToString("yyyy-MM-dd H:mm:ss zzz");
            string anonymousUserId = "";
            for (int i = 0; i < questions.Length - 1; i++)
            {
                SqlCategories.InsertParameters["ModuleId"].DefaultValue = this.ModuleId.ToString();
                SqlCategories.InsertParameters["QuestionnaireID"].DefaultValue = timestamp;
                SqlCategories.InsertParameters["QuestionID"].DefaultValue = questions[i];
                SqlCategories.InsertParameters["Locale"].DefaultValue = Culture;
                SqlCategories.InsertParameters["TargetedCountry"].DefaultValue = targetCountry;
                SqlCategories.InsertParameters["AnswerID"].DefaultValue = answers[i];
                SqlCategories.InsertParameters["AnsweredOnDate"].DefaultValue = datetime;

                if (Request.IsAuthenticated)
                {
                    SqlCategories.InsertParameters["AnsweredByUser"].DefaultValue = this.UserId.ToString();
                    SqlCategories.InsertParameters["AnonymousGuid"].DefaultValue = "";
                }
                else
                {
                    HttpCookie pbpCookie = Request.Cookies.Get("puzzledByPolicy");
                    if (pbpCookie != null)
                    {
                        anonymousUserId = pbpCookie["anonymousId"];
                    }
                    else
                    {
                        anonymousUserId = SetCookie("puzzledByPolicy").ToString();
                    }
                    SqlCategories.InsertParameters["AnsweredByUser"].DefaultValue = "-1";
                    SqlCategories.InsertParameters["AnonymousGuid"].DefaultValue = anonymousUserId;
                }
                // IP  = Request.UserHostAddress()
                SqlCategories.InsertParameters["Rating"].DefaultValue = ratings[i];
                try
                {
                    SqlCategories.Insert();
                }
                catch (FormatException ex)
                {
                    Response.Redirect("http://join.puzzledbypolicy.eu/");
                }
            }

            LinkButton sendingBtn = (LinkButton)sender;

            /* If SubmitDemogBtn has been clicked, we also save the demographics
             * answers
             */
            if (sendingBtn.ID.Equals("SubmitDemogBtn"))
            {
                if (Request.IsAuthenticated)
                {
                    SqlDemographics.InsertParameters["userID"].DefaultValue = this.UserId.ToString();
                }
                else
                    SqlDemographics.InsertParameters["userID"].DefaultValue = anonymousUserId;

                SqlDemographics.InsertParameters["QuestionnaireID"].DefaultValue = timestamp;

                if (!DEM_birthplace.Value.Equals(""))
                    SqlDemographics.InsertParameters["Question1"].DefaultValue = DEM_birthplace.Value;
                if (!DEM_livingplace.Value.Equals(""))
                    SqlDemographics.InsertParameters["Question2"].DefaultValue = DEM_livingplace.Value;
                if (!DEM_age.Value.Equals(""))
                    SqlDemographics.InsertParameters["Question3"].DefaultValue = DEM_age.Value;
                if (!DEM_sex.Value.Equals(""))
                    SqlDemographics.InsertParameters["Question4"].DefaultValue = DEM_sex.Value;
                if (!DEM_education.Value.Equals(""))
                    SqlDemographics.InsertParameters["Question5"].DefaultValue = DEM_education.Value;
                if (!DEM_profession.Value.Equals(""))
                    SqlDemographics.InsertParameters["Question6"].DefaultValue = DEM_profession.Value;
                if (!DEM_municipality.Value.Equals(""))
                    SqlDemographics.InsertParameters["Question7"].DefaultValue = DEM_municipality.Value;

                try
                {
                    SqlDemographics.Insert();
                }
                catch (FormatException ex)
                {
                    Response.Write(ex.Message);
                    return;
                    //Response.Redirect("http://join.puzzledbypolicy.eu/");
                }
            }

            LinkButton save = (LinkButton)ResultsPanel.FindControl("SaveButton");
            LinkButton clear = (LinkButton)ResultsPanel.FindControl("ClearButton");
            HyperLink feedback = (HyperLink)ResultsPanel.FindControl("FeedbackButton");

            save.CssClass = "saveBtn sBtn_" + Culture;
            clear.CssClass = "clearBtn clBtn_" + Culture;

            feedback.CssClass = "feedbackBtn fBtn_" + Culture;
            feedback.NavigateUrl = ConfigurationManager.AppSettings["DomainName"] + "/" + Culture + "/feedback.aspx";
            feedback.Target = "_blank";

            /*We set the hidden field to false so as not to popup the demographics
            * unless we reload the profiler
             */
            //showDemographicsPopup.Value = "false";


            /* Link with u-Debate.
             * 
             * Completely agree/disagree: 3 points
             * Tend to agree/disagree :   1 point
             * Neutral/No opinion:       0 points
             * 
             * Multiply by Ratings  1 -> 1
             *                      2 -> 2
             *                      3 -> 3
             *                      
             * Category   Questions
             *    1         2  - 4
             *    2         5  - 6
             *    3         7  - 8
             *    4         9  - 11
             *    5         12 - 14
             */

            int[] weights = new int[13]; // 13 questions
            int[] extremes = new int[5];
            /* We skip the first(general) and last(specific) questions (plus the last empty cell) */
            for (int an = 1; an <= answers.Length - 3; an++)
            {
                if (answers[an] == "1" || answers[an] == "5")
                    weights[an - 1] = 3;
                else if (answers[an] == "2" || answers[an] == "4")
                    weights[an - 1] = 1;
                else
                    weights[an - 1] = 0;
                if (Convert.ToInt32(ratings[an]) > 0)
                    weights[an - 1] *= Convert.ToInt32(ratings[an]);
            }
            extremes[0] = weights[0] + weights[1] + weights[2]; // employment
            extremes[1] = weights[3] + weights[4];              //studying
            extremes[2] = weights[5] + weights[6];              //family reunification
            extremes[3] = weights[7] + weights[8] + weights[9];  //Long-term resident immigrants and citizenship
            extremes[4] = weights[10] + weights[11] + weights[12];//Irregular migration, re-admission and return

            int topExtreme = 0;

            for (int i = 0; i < 5; i++)
            {
                if (extremes[i] > extremes[topExtreme])
                {
                    topExtreme = i;
                }
            }
            string threadUrl = String.Empty;

            string uDebateText = String.Empty;
            /* Check if the user had selected no answer/neutral in all questions
             * and just link to the home debate page if this is true
             */
            if (extremes[topExtreme] > 0)
                uDebateText = Localization.GetString("uDebateLink" + (topExtreme + 1) + ".Text", LocalResourceFile);
            else
                topExtreme = -1; // no answer so we go to the default threadurl

            if (Culture == "en-GB")
            {
                switch (topExtreme)
                {
                    case 0: threadUrl = fetchThreadUrl("59", Culture); break;
                    case 1: threadUrl = fetchThreadUrl("60", Culture); break;
                    case 2: threadUrl = fetchThreadUrl("61", Culture); break;
                    case 3: threadUrl = fetchThreadUrl("62", Culture); break;
                    case 4: threadUrl = fetchThreadUrl("63", Culture); break;
                    default: threadUrl = "http://join.puzzledbypolicy.eu/en-GB/uDebate.aspx"; break;
                }
            }
            else
            {
                switch (targetCountry)
                {
                    case "el-GR": switch (topExtreme)
                        {
                            case 0: threadUrl = fetchThreadUrl("65", Culture); break;
                            case 1: threadUrl = fetchThreadUrl("76", Culture); break;
                            case 2: threadUrl = fetchThreadUrl("77", Culture); break;
                            case 3: threadUrl = fetchThreadUrl("69", Culture); break;
                            case 4: threadUrl = fetchThreadUrl("71", Culture); break;
                            default: threadUrl = "http://join.puzzledbypolicy.eu/el-GR/uDebate.aspx"; break;
                        }
                        break;
                    case "es-ES": switch (topExtreme)
                        {
                            case 0: threadUrl = fetchThreadUrl("35", Culture); break;
                            case 1: threadUrl = fetchThreadUrl("36", Culture); break;
                            case 2: threadUrl = fetchThreadUrl("37", Culture); break;
                            case 3: threadUrl = fetchThreadUrl("38", Culture); break;
                            case 4: threadUrl = fetchThreadUrl("39", Culture); break;
                            default: threadUrl = "http://join.puzzledbypolicy.eu/es-ES/uDebate.aspx"; break;
                        }
                        break;
                    case "it-IT": switch (topExtreme)
                        {
                            case 0: threadUrl = fetchThreadUrl("26", Culture); break;
                            case 1: threadUrl = fetchThreadUrl("48", Culture); break;
                            case 2: threadUrl = fetchThreadUrl("49", Culture); break;
                            case 3: threadUrl = fetchThreadUrl("50", Culture); break;
                            case 4: threadUrl = fetchThreadUrl("51", Culture); break;
                            default: threadUrl = "http://join.puzzledbypolicy.eu/it-IT/uDebate.aspx"; break;
                        }
                        break;
                    case "hu-HU": switch (topExtreme)
                        {
                            case 0: threadUrl = fetchThreadUrl("42", Culture); break;
                            case 1: threadUrl = fetchThreadUrl("72", Culture); break;
                            case 2: threadUrl = fetchThreadUrl("73", Culture); break;
                            case 3: threadUrl = fetchThreadUrl("74", Culture); break;
                            case 4: threadUrl = fetchThreadUrl("75", Culture); break;
                            default: threadUrl = "http://join.puzzledbypolicy.eu/hu-HU/uDebate.aspx"; break;
                        }
                        break;
                    default: switch (topExtreme)
                        {
                            case 0: threadUrl = fetchThreadUrl("59", Culture); break;
                            case 1: threadUrl = fetchThreadUrl("60", Culture); break;
                            case 2: threadUrl = fetchThreadUrl("61", Culture); break;
                            case 3: threadUrl = fetchThreadUrl("62", Culture); break;
                            case 4: threadUrl = fetchThreadUrl("63", Culture); break;
                            default: threadUrl = "http://join.puzzledbypolicy.eu/en-GB/uDebate.aspx"; break;
                        }
                        break;
                }
            }

            if (!Page.ClientScript.IsClientScriptBlockRegistered("exampleScript"))
                Page.ClientScript.RegisterStartupScript(this.GetType(), "exampleScript", @"
                <script language = 'javascript'>
                  jQuery(document).ready(function() {
                       jQuery('#uDebateProposal').html(""<h3>"
                     + Localization.GetString("uDebateHeader.Text", LocalResourceFile) + "</h3>"
                     + uDebateText + "<p align='center'> <a href='" + threadUrl
                     + @"' target='_blank'>"
                     + Localization.GetString("TakePart", LocalResourceFile) + @"</a></p>"");
                         jQuery('.trigger').show();
                         jQuery('.trigger').addClass('active'); 
                         jQuery('.uDebateLinkDiv').show();                         
                  });
                </script>
                ");

            //jQuery('#uDebateLinkDiv').animate({'bottom': '+=213px'}, 4000);

            //String host = ConfigurationManager.AppSettings["hostServer"];
            //String host = "http://join.puzzledbypolicy.eu";
            String host = ConfigurationManager.AppSettings["DomainName"];

            String resultsService = host +
                            "/PProfilerResults/BarChartData.aspx?questions=" +
                            HiddenQuestions.Value + "&answers=" +
                            HiddenAnswers.Value + "&ratings=" +
                            HiddenRatings.Value + "&locale=" + targetCountry;

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(new StringReader(GetMessage(resultsService)));

            XmlNodeList xmlnodelist = xmlDoc.GetElementsByTagName("graph");

            if (xmlnodelist.Count > 0)
            {
                XmlNode xmlnode = xmlnodelist.Item(0);

                XmlNodeList valueslist = xmlnode.ChildNodes;

                foreach (XmlNode value in valueslist)
                {
                    ProfilerResults += value.Attributes["title"].Value + ": ";
                    ProfilerResults += value.InnerText + "% ";
                }
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            /* If the user is authenticated the answers will
             * be saved in db
             */
            if (Request.IsAuthenticated)
            {
                String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString();
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    String queryString = " INSERT INTO ATC_PolicyProfiler_SavedAnswers (UserID,UserAnswers,UserRatings) VALUES( " +
                                               this.UserId.ToString() + ",'" + HiddenAnswers.Value + "','" +
                                               HiddenRatings.Value + "')";
                    SqlCommand command = new SqlCommand(queryString, connection);
                    command.Connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        private String GetTimestamp(DateTime value)
        {
            return value.ToString("yyMMddHHmmssff");
        }

        private Guid SetCookie(string cookieName)
        {
            HttpCookie aCookie = new HttpCookie(cookieName);
            Guid anonymousUserGuid = Guid.NewGuid();
            aCookie.Values["anonymousId"] = anonymousUserGuid.ToString();
            aCookie.Values["lastUpdated"] = DateTime.Now.ToString();
            aCookie.Expires = DateTime.Now.AddDays(30);
            Response.Cookies.Add(aCookie);
            return anonymousUserGuid;
        }

        public string GetMessage(string endPoint)
        {
            HttpWebRequest request = CreateWebRequest(endPoint);

            using (var response = (HttpWebResponse)request.GetResponse())
            {
                var responseValue = string.Empty;

                if (response.StatusCode != HttpStatusCode.OK)
                {
                    string message = String.Format("POST failed. Received HTTP {0}", response.StatusCode);
                    throw new ApplicationException(message);
                }

                // grab the response
                using (var responseStream = response.GetResponseStream())
                {
                    using (var reader = new StreamReader(responseStream))
                    {
                        responseValue = reader.ReadToEnd();
                    }
                }
                return responseValue;
            }
        }


        private HttpWebRequest CreateWebRequest(string endPoint)
        {
            var request = (HttpWebRequest)WebRequest.Create(endPoint);

            request.Method = "GET";
            request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
            request.KeepAlive = true;
            request.UserAgent = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11";

            /* required for localhost only */
            //if (ConfigurationManager.AppSettings["useProxy"] == "true")
            //{
            //    request.Proxy = GetProxy();
            //}
            return request;
        }

        public IWebProxy GetProxy()
        {
            string PROXY_IP = "10.151.64.1"; // ConfigurationManager.AppSettings["proxyIP"];

            string PROXY_PORT = "8080"; // ConfigurationManager.AppSettings["proxyPort"];
            string PROXY_USERNAME = "lkallipolitis"; //ConfigurationManager.AppSettings["proxyUsername"];
            string PROXY_PASSWORD = "foaGTH13"; //ConfigurationManager.AppSettings["proxyPassword"];

            IWebProxy proxy = null;
            ICredentials credentials = null;

            if (!PROXY_IP.Equals(String.Empty) && !PROXY_PORT.Equals(String.Empty))
            {
                if (!PROXY_USERNAME.Equals(String.Empty) && !PROXY_PASSWORD.Equals(String.Empty))
                {
                    // Create proxy credentials
                    credentials = new NetworkCredential(PROXY_USERNAME, PROXY_PASSWORD);
                }
                // Create proxy object
                proxy = new WebProxy(PROXY_IP + ":" + PROXY_PORT, true, null, credentials);
            }

            return proxy;
        }


        protected void languageSelector_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList LanguageSelector = (DropDownList)CategoriesDataList.FindControl("LanguageSelector");

            String selectedLang = LanguageSelector.SelectedValue;

            /* Set the select parameters for the sql sources*/
            SqlCategories.SelectParameters["Locale"].DefaultValue = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            SqlCategories.SelectParameters["TargetedCountry"].DefaultValue = selectedLang;
            SqlStakeholders.SelectParameters["Country"].DefaultValue = selectedLang.Equals("en-GB") ? "EU" : selectedLang;
            SqlCountries.SelectParameters["Language"].DefaultValue = selectedLang;

            /* Refresh the sql sources*/
            SqlCategories.DataBind();
            SqlStakeholders.DataBind();
            SqlCountries.DataBind();

            /* Refresh the controls */
            //PartySelector.DataBind();
        }

        protected void checkedCategories_DataBound(object sender, EventArgs e)
        {
            ListItemCollection checkedCats = checkedCategories.Items;
            CheckBox showInt = ResultsPanel.FindControl("showIntStakeholders") as CheckBox;

            /* Remove last (special) and the first (general) categories */
            
            if (checkedCats.Count > 6) // check that there is the 'special' category (= 'Other' selected in start)
            {
                checkedCats.RemoveAt(6);
                showInt.Visible = true;
            }
            else
            {
                showInt.Visible = false;
            }
            checkedCats.RemoveAt(0);

            for (int i = 0; i < checkedCats.Count; i++)
            {
                checkedCats[i].Selected = true;
                checkedCats[i].Attributes.Add("Name", "checkedCategories");
            }


        }

        protected void CategoriesDataList_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string Culture = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
                DropDownList LanguageSelector = (DropDownList)CategoriesDataList.FindControl("LanguageSelector");

               //LanguageSelector.SelectedValue = Culture;

               // /* Hide the 'other' option if current locale is not english*/
               // if (!Culture.Equals("en-GB"))
               // {
               //     LanguageSelector.Items.RemoveAt(4);
               // }

                Panel startPanel = (Panel)CategoriesDataList.FindControl("IntroPanel");
                startPanel.CssClass = "IntroDiv In_" + Culture;
            }
        }

        protected void BirthPlaceDropD_DataBound(object sender, EventArgs e)
        {
            DropDownList thisList = (DropDownList)sender;
            String country = "United Kingdom";
            switch (System.Threading.Thread.CurrentThread.CurrentCulture.Name)
            {
                case "el-GR": country = "Ελλάδα"; break;
                case "it-IT": country = "Italia"; break;
                case "hu-HU": country = "Magyarország"; break;
                case "es-ES": country = "España"; break;
                default: country = "United Kingdom"; break;
            }
            thisList.SelectedValue = country;
        }

        protected void LivingPlaceDropD_DataBound(object sender, EventArgs e)
        {
            DropDownList thisList = (DropDownList)sender;
            String country = "United Kingdom";
            switch (System.Threading.Thread.CurrentThread.CurrentCulture.Name)
            {
                case "el-GR": country = "Ελλάδα"; break;
                case "it-IT": country = "Italia"; break;
                case "hu-HU": country = "Magyarország"; break;
                case "es-ES": country = "España"; break;
                default: country = "United Kingdom"; break;
            }
            thisList.SelectedValue = country;
        }

        /* Find the item with UK value and rename the label to 'all'*/
        protected void CountrySelector_DataBound(object sender, EventArgs e)
        {
            ListItemCollection options = CountrySelector.Items;
            ListItem allOption = new ListItem(Localization.GetString("Overview.Text", LocalResourceFile), "all");
            options.Add(allOption);
            options[options.Count - 1].Selected = true;

            /* THe UK option only appears in the development database*/
            /* foreach (ListItem myItem in CountrySelector.Items)
             {
                 if (myItem.Value.Equals("UK"))
                     myItem.Text = Localization.GetString("Overview.Text", LocalResourceFile);
             }*/
        }

        protected void ClearButton_Click(object sender, EventArgs e)
        {
            Session["LoadedSaved"] = "";
            Page.Response.Redirect(HttpContext.Current.Request.Url.ToString(), true);
        }

        public string fetchThreadUrl(string topicId, string language)
        {
            return "http://join.puzzledbypolicy.eu/" + language + "/udebatethreads.aspx?TopicID=" + topicId;
        }

        protected string showDemographics()
        {
            String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                String queryString = " SELECT userID FROM ATC_PolicyProfiler_Demographics " +
                                    " WHERE userID='" + this.UserId.ToString() + "'";

                SqlCommand command = new SqlCommand(queryString, connection);
                command.Connection.Open();
                String result = (String)command.ExecuteScalar();
                if (result != null)
                {
                    return "true";
                }
                return "false";
            }
        }
    }
}