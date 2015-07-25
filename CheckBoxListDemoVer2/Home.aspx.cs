using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CheckBoxListDemoVer2.Models;

namespace CheckBoxListDemoVer2
{
    public partial class Home : System.Web.UI.Page
    {
         
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
              
                GetAllDepartmentInDropDownlist();
                GetAllDealerInDropDownlist();

                GetAllSettingName(Convert.ToInt32(dealerDropDownList.SelectedValue));
                ListItem listItem = new ListItem("Select setting","-1");
                settingNameDropDownList.Items.Insert(0,listItem);
            }
        }
        
        
        public void GetAllSettingName(int initialValue)
        {
         
            settingNameDropDownList.DataSource = GetAllUserSettingName(initialValue);
            settingNameDropDownList.DataTextField = "SettingName";
            settingNameDropDownList.DataValueField = "ID";
            settingNameDropDownList.DataBind();
        }

        public void GetAllDealerInDropDownlist()
        {
            dealerDropDownList.DataSource = GetAllDealer();
            dealerDropDownList.DataTextField = "Name";
            dealerDropDownList.DataValueField = "ID";
            dealerDropDownList.DataBind();
        }
        public void GetAllDepartmentInDropDownlist()
        {
            ux_lstDepartments.DataSource = GetAllDepartment();
            ux_lstDepartments.DataTextField = "DepartmentName";
            ux_lstDepartments.DataValueField = "ID";
            ux_lstDepartments.DataBind();
        }

        public List<UserSettingNameModel> GetAllUserSettingName(int initialValue)
        {
            List<UserSettingNameModel> userSettingNameModels = new List<UserSettingNameModel>();
            string query = String.Format("Select * from tblSettingName where DealerId=@dealerId");
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@dealerId",initialValue);
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        UserSettingNameModel userSettingNameModel = new UserSettingNameModel();
                        userSettingNameModel.ID = Convert.ToInt32(rdr[0]);
                        userSettingNameModel.SettingName = rdr[1].ToString();
                        userSettingNameModels.Add(userSettingNameModel);
                    }
                    con.Close();
                }
            }
            return userSettingNameModels;
        }

        public List<DepartmentModel> GetAllDepartment()
        {
            List<DepartmentModel> departmentModels = new List<DepartmentModel>();
            string query = String.Format("Select * from tblDepartment");
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query,con))
                {
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        DepartmentModel departmentModel = new DepartmentModel();
                        departmentModel.ID = Convert.ToInt32(rdr[0]);
                        departmentModel.DepartmentName = rdr[1].ToString();
                        departmentModels.Add(departmentModel);
                    }
                    con.Close();
                }
            }
            return departmentModels;
        }

        public List<DealerModel> GetAllDealer()
        {
            List<DealerModel> dealerModels = new List<DealerModel>();
            string query = String.Format("Select * from tblDealer");
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        DealerModel dealerModel = new DealerModel();
                        dealerModel.ID = Convert.ToInt32(rdr[0]);
                        dealerModel.Name = rdr[1].ToString();
                       dealerModels.Add(dealerModel);
                    }
                    con.Close();
                }
            }
            return dealerModels;
        }
       
        public bool IsSettingNameExist(string settingName,int dealerId)
        {
            bool isSettingNameExist = false;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString))
            {
                string query = String.Format("Select * from tblSettingName where SettingName=@settingName and DealerId=@dealerId");
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Clear();
                    command.Parameters.AddWithValue("@settingName",settingName);
                    command.Parameters.AddWithValue("@dealerId",dealerId);

                    connection.Open();
                    SqlDataReader rdr = command.ExecuteReader();
                    while (rdr.Read())
                    {
                        isSettingNameExist = true;
                    }
                    connection.Close();
                }
            }
            return isSettingNameExist;
        }

        protected void createButton_Click(object sender, EventArgs e)
        {
            int lastIdentityValue = 0;
            UserSettingNameModel userSettingNameModel = new UserSettingNameModel();
            userSettingNameModel.SettingName = settingTextBox.Text;
            userSettingNameModel.DealerId = Convert.ToInt32(dealerDropDownList.SelectedValue);

            if (settingTextBox.Text =="")
            {
                statusLabel.Text = "Please enter the setting name.";
            }
            else
            {
                if (IsSettingNameExist(settingTextBox.Text,Convert.ToInt32(dealerDropDownList.SelectedValue)))
                {
                    statusLabel.Text = "This setting name already exist.";
                }
                else
                {
                    if (SaveSettingName(userSettingNameModel)< 1)
                    {
                        statusLabel.Text = "Setting name not saved.";
                    }
                    else
                    {
                        lastIdentityValue = GetLastIdentityValue();
                        List<UserSettingModel> userSettingModels = new List<UserSettingModel>();
                        foreach (var ctrl in Panel1.Controls)
                        {
                            UserSettingModel userSettingModel = new UserSettingModel();
                            if (ctrl is CheckBox)
                            {

                                if ((((CheckBox)ctrl).Checked))
                                {

                                    CheckBox chk = ctrl as CheckBox;
                                    userSettingModel.UserControlId = chk.ID;
                                    userSettingModel.Status = "True";
                                    userSettingModel.settingNameId = lastIdentityValue;
                                }
                                else
                                {
                                    CheckBox chk = ctrl as CheckBox;
                                    userSettingModel.UserControlId = chk.ID;
                                    userSettingModel.Status = "False";
                                    userSettingModel.settingNameId = lastIdentityValue; ;
                                }                                                  
                                userSettingModels.Add(userSettingModel);
                            }

                        }

                        foreach (var ctrl in Panel2.Controls)
                        {
                            string selectedValueText = "";
                            UserSettingModel userSettingModel = new UserSettingModel();
                            if (ctrl is DropDownList)
                            {
                                DropDownList ddl = ctrl as DropDownList;
                                userSettingModel.UserControlId = ddl.ID;
                                selectedValueText += ddl.SelectedValue +"|"+ ddl.SelectedItem.Text;
                                userSettingModel.Status = selectedValueText;
                                userSettingModel.settingNameId = lastIdentityValue;
                                userSettingModels.Add(userSettingModel);
                            }

                        }

                        foreach (var ctrl in Panel3.Controls)
                        {
                            UserSettingModel userSettingModel = new UserSettingModel();
                            if (ctrl is CheckBox)
                            {

                                if ((((CheckBox)ctrl).Checked))
                                {

                                    CheckBox chk = ctrl as CheckBox;
                                    userSettingModel.UserControlId = chk.ID;
                                    userSettingModel.Status = "True";
                                    userSettingModel.settingNameId = lastIdentityValue;
                                }
                                else
                                {
                                    CheckBox chk = ctrl as CheckBox;
                                    userSettingModel.UserControlId = chk.ID;
                                    userSettingModel.Status = "False";
                                    userSettingModel.settingNameId = lastIdentityValue; 
                                }                               
                                userSettingModels.Add(userSettingModel);
                            }

                        }

                        foreach (var ctrl in Panel4.Controls)
                        {
                            string selectedValueText = "";
                            UserSettingModel userSettingModel = new UserSettingModel();
                            if (ctrl is DropDownList)
                            {
                                DropDownList ddl = ctrl as DropDownList;
                                userSettingModel.UserControlId = ddl.ID;
                                selectedValueText += ddl.SelectedValue + "|" + ddl.SelectedItem.Text;
                                userSettingModel.Status = selectedValueText;
                                userSettingModel.settingNameId = lastIdentityValue;
                                userSettingModels.Add(userSettingModel);
                            }

                        }
                       
                        foreach (var ctrl in Panel6.Controls)
                        {
                            string selectedValueText = "";
                            UserSettingModel userSettingModel = new UserSettingModel();
                            if (ctrl is DropDownList)
                            {
                                DropDownList ddl = ctrl as DropDownList;
                                userSettingModel.UserControlId = ddl.ID;
                                ////
                                if (ddl.Items.Count == 0)
                                {
                                    selectedValueText = "-3|noValue";
                                    userSettingModel.Status = selectedValueText;
                                    userSettingModel.settingNameId = lastIdentityValue;
                                    userSettingModels.Add(userSettingModel);
                                }
                                else
                                {
                                    selectedValueText += ddl.SelectedValue + "|" + ddl.SelectedItem.Text;
                                    userSettingModel.Status = selectedValueText;
                                    userSettingModel.settingNameId = lastIdentityValue;
                                    userSettingModels.Add(userSettingModel);
                                }
                             
                                

                                ////
                                
                            }

                        }
                          if (SaveUserSettingsPerName(userSettingModels) > 0)
                          {
                              statusLabel.Text = "Saved";
                              GetAllSettingName(Convert.ToInt32(dealerDropDownList.SelectedValue));
                              ListItem listItem = new ListItem("Select setting", "-1");
                              settingNameDropDownList.Items.Insert(0, listItem);
                              int count = 0;
                              foreach (ListItem item in settingNameDropDownList.Items)
                              {
                                  count++;
                              }
                              ListItem tempListItem = settingNameDropDownList.Items[count - 1];
                              settingNameDropDownList.Items.RemoveAt(count - 1);
                              settingNameDropDownList.Items.Insert(0, tempListItem);
                          }
                            else
                            {
                                statusLabel.Text = "Not saved";
                            }                                            
                    }
                }
            }               
        }

        public int GetLastIdentityValue()
        {
            int lastIdentityValue = 0;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString))
            {
                string query = String.Format("Select IDENT_CURRENT('tblSettingName')");
                using (SqlCommand command = new SqlCommand(query,connection))
                {
                    connection.Open();
                    lastIdentityValue = Convert.ToInt32(command.ExecuteScalar());
                    connection.Close();
                }
            }
            return lastIdentityValue;
        }

        public int SaveSettingName(UserSettingNameModel userSettingNameModel)
        {
            int rowsInserted = 0;
            string query = String.Format("Insert into tblSettingName values(@settingName,@dealerId)");
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand(query,connection))
                {
                    command.Parameters.Clear();
                    command.Parameters.AddWithValue("@settingName", userSettingNameModel.SettingName);
                    command.Parameters.AddWithValue("@dealerId", userSettingNameModel.DealerId);
                    connection.Open();
                    rowsInserted = command.ExecuteNonQuery();
                    connection.Close();
                }
            }

            return rowsInserted;
        }

        public int SaveUserSettingsPerName(List<UserSettingModel> userSettingModels)
        {
            int rowsInserted = 0;
           
            foreach (UserSettingModel userSettingModel in userSettingModels)
            {
                 string query = String.Format("Insert into tblUserAtDealer values('{0}','{1}','{2}')",userSettingModel.UserControlId,userSettingModel.Status,userSettingModel.settingNameId);
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString))
                {
                    using (SqlCommand command = new SqlCommand(query,connection))
                    {
                        connection.Open();
                        rowsInserted = command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
            }
            return rowsInserted;
        }


        //update..............................................
        protected void upDateButton_Click(object sender, EventArgs e)
        {
            List<UserSettingModel> userSettingModels = new List<UserSettingModel>();
            foreach (var ctrl in Panel1.Controls)
            {
                UserSettingModel userSettingModel = new UserSettingModel();
                if (ctrl is CheckBox)
                {
                    if ((((CheckBox)ctrl).Checked))
                    {
                        CheckBox chk = ctrl as CheckBox;
                        userSettingModel.UserControlId = chk.ID;
                        userSettingModel.Status = "True";
                        userSettingModel.settingNameId = Convert.ToInt32(settingNameDropDownList.SelectedValue);
                    }
                    else
                    {
                        CheckBox chk = ctrl as CheckBox;
                        userSettingModel.UserControlId = chk.ID;
                        userSettingModel.Status = "False";
                        userSettingModel.settingNameId = Convert.ToInt32(settingNameDropDownList.SelectedValue);
                    }                                      
                    userSettingModels.Add(userSettingModel);
                }
            }

            foreach (var ctrl in Panel2.Controls)
            {
                string selectedValueText = "";
                UserSettingModel userSettingModel = new UserSettingModel();
                if (ctrl is DropDownList)
                {
                    DropDownList ddl = ctrl as DropDownList;
                    userSettingModel.UserControlId = ddl.ID;
                    selectedValueText += ddl.SelectedValue + "|" + ddl.SelectedItem.Text;
                    userSettingModel.Status = selectedValueText;
                    userSettingModel.settingNameId = Convert.ToInt32(settingNameDropDownList.SelectedValue);
                    userSettingModels.Add(userSettingModel);
                }
            }

            foreach (var ctrl in Panel3.Controls)
            {
                UserSettingModel userSettingModel = new UserSettingModel();
                if (ctrl is CheckBox)
                {

                    if ((((CheckBox)ctrl).Checked))
                    {

                        CheckBox chk = ctrl as CheckBox;
                        userSettingModel.UserControlId = chk.ID;
                        userSettingModel.Status = "True";
                        userSettingModel.settingNameId = Convert.ToInt32(settingNameDropDownList.SelectedValue);
                    }
                    else
                    {
                        CheckBox chk = ctrl as CheckBox;
                        userSettingModel.UserControlId = chk.ID;
                        userSettingModel.Status = "False";
                        userSettingModel.settingNameId = Convert.ToInt32(settingNameDropDownList.SelectedValue);
                    }                    
                    userSettingModels.Add(userSettingModel);
                }

            }

            foreach (var ctrl in Panel4.Controls)
            {
                string selectedValueText = "";
                UserSettingModel userSettingModel = new UserSettingModel();
                if (ctrl is DropDownList)
                {
                    DropDownList ddl = ctrl as DropDownList;
                    userSettingModel.UserControlId = ddl.ID;
                    selectedValueText += ddl.SelectedValue + "|" + ddl.SelectedItem.Text;
                    userSettingModel.Status = selectedValueText;
                    userSettingModel.settingNameId = Convert.ToInt32(settingNameDropDownList.SelectedValue);
                    userSettingModels.Add(userSettingModel);
                }
            }

           
            foreach (var ctrl in Panel6.Controls)
            {
                string selectedValueText = "";
                UserSettingModel userSettingModel = new UserSettingModel();
                if (ctrl is DropDownList)
                {
                    DropDownList ddl = ctrl as DropDownList;
                    userSettingModel.UserControlId = ddl.ID;
                    ////
                    if (ddl.Items.Count == 0)
                    {
                        selectedValueText = "-3|noValue";
                        userSettingModel.Status = selectedValueText;
                        userSettingModel.settingNameId = Convert.ToInt32(settingNameDropDownList.SelectedValue);
                        userSettingModels.Add(userSettingModel);
                    }
                    else
                    {
                        selectedValueText += ddl.SelectedValue + "|" + ddl.SelectedItem.Text;
                        userSettingModel.Status = selectedValueText;
                        userSettingModel.settingNameId = Convert.ToInt32(settingNameDropDownList.SelectedValue);
                        userSettingModels.Add(userSettingModel);
                    }



                   

                }
               
            }
            if (UpdateUserSettingPerName(userSettingModels) > 0)
            {
                statusLabel.Text = "Updated";
                //ListItem listItem = new ListItem("Select setting", "-1");
                //settingNameDropDownList.Items.Insert(0, listItem);

            }
            else
            {
                statusLabel.Text = "Not updated";
            }
            
            

        }


        public int UpdateUserSettingPerName(List<UserSettingModel> userSettingModels)
        {
            int rowsUpdated = 0;
           
            foreach (UserSettingModel userSettingModel in userSettingModels)
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString))
            {
                string query = String.Format("Update tblUserAtDealer set Status=@status where UserControlId=@userControlId and SettingNameId=@settingNameId");
                
                using (SqlCommand command = new SqlCommand(query,connection))
                {
                    command.Parameters.Clear();
                    command.Parameters.AddWithValue("@status", userSettingModel.Status);
                    command.Parameters.AddWithValue("@userControlId",userSettingModel.UserControlId);
                    command.Parameters.AddWithValue("@settingNameId", userSettingModel.settingNameId);
                    connection.Open();
                    rowsUpdated = command.ExecuteNonQuery();
                    connection.Close();
                }
            }            
            }
            return rowsUpdated;
        }

        public int DeleteUserSetting(int settingNameId)
        {
            int rowsDeleted = 0;
            
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString))
            {
                string query = String.Format("Delete from tblSettingName where ID=@settingNameId");
                using (SqlCommand command = new SqlCommand(query,connection))
                {
                    command.Parameters.Clear();
                    command.Parameters.AddWithValue("@settingNameId", settingNameId);
                    connection.Open();
                    rowsDeleted = command.ExecuteNonQuery();
                    connection.Close();
                }
            }
            return rowsDeleted;
        }

        protected void deleteButton_Click(object sender, EventArgs e)
        {
            if (settingNameDropDownList.SelectedValue == "-1")
            {
                statusLabel.Text = "Please select a value.";
            }
            else
            {
                if (DeleteUserSetting(Convert.ToInt32(settingNameDropDownList.SelectedValue)) > 0)
                {                    
                    statusLabel.Text = "Delated";
                    GetAllSettingName(Convert.ToInt32(dealerDropDownList.SelectedValue));
                    ListItem listItem = new ListItem("Select setting", "-1");
                    settingNameDropDownList.Items.Insert(0, listItem);
                }
                else
                {
                    statusLabel.Text = "Not delated";
                }
            }
           

        }

        protected void dealerDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            CleaeAllField();
            settingNameDropDownList.DataSource = GetSettingNameRelatedToDealer(Convert.ToInt32(dealerDropDownList.SelectedValue));
            settingNameDropDownList.DataTextField = "SettingName";
            settingNameDropDownList.DataValueField = "ID";
            settingNameDropDownList.DataBind();

            ListItem listItem = new ListItem("Select setting", "-1");
            settingNameDropDownList.Items.Insert(0, listItem);

        }

        private List<UserSettingNameModel> GetSettingNameRelatedToDealer(int dealerId)
        {
            List<UserSettingNameModel> userSettingNameModels = new List<UserSettingNameModel>();
            string query = String.Format("Select * from tblSettingName where DealerId=@dealerId");

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand(query,connection))
                {
                    command.Parameters.Clear();
                    command.Parameters.AddWithValue("@dealerId", dealerId);
                    connection.Open();
                    SqlDataReader rdr = command.ExecuteReader();
                    while (rdr.Read())
                    {
                        UserSettingNameModel userSettingNameModel = new UserSettingNameModel();
                        userSettingNameModel.ID = Convert.ToInt32(rdr[0]);
                        userSettingNameModel.SettingName = rdr[1].ToString();
                        userSettingNameModels.Add(userSettingNameModel);
                    }                                        
                    connection.Close();
                }
            }
            return userSettingNameModels;
        }

        protected void settingNameDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
           List<UserSettingModel> userSettingModels = new List<UserSettingModel>();
            userSettingModels = GetAllSettingBySelectedSettingId(Convert.ToInt32(settingNameDropDownList.SelectedValue));

            foreach (UserSettingModel userSettingModel in userSettingModels)
            {
                foreach (var ctrl in Panel1.Controls)
                {                    
                    if (ctrl is CheckBox)
                    {                     
                        CheckBox chk = ctrl as CheckBox;
                        if (chk.ID == userSettingModel.UserControlId && userSettingModel.Status=="True")
                        {
                            ((CheckBox) ctrl).Checked = true;
                            break;
                        }
                        else if (chk.ID == userSettingModel.UserControlId && userSettingModel.Status == "False")
                        {
                            ((CheckBox)ctrl).Checked = false;
                            break;
                        }                                                
                    }

                }
                foreach (var ctrl in Panel2.Controls)
                {
                    if (ctrl is DropDownList)
                    {
                        DropDownList ddl = ctrl as DropDownList;

                        if (ddl.ID == userSettingModel.UserControlId)
                        {
                            string str = userSettingModel.Status;
                            string[] str1 = str.Split(new char[] { '|' });

                            ddl.SelectedValue = str1[0];
                            ddl.SelectedItem.Text = str1[1];

                            break;
                        }
                    }
                }
                //another
                foreach (var ctrl in Panel3.Controls)
                {
                    if (ctrl is CheckBox)
                    {
                        CheckBox chk = ctrl as CheckBox;
                        if (chk.ID == userSettingModel.UserControlId && userSettingModel.Status == "True")
                        {
                            ((CheckBox)ctrl).Checked = true;
                            break;
                        }
                        else if (chk.ID == userSettingModel.UserControlId && userSettingModel.Status == "False")
                        {
                            ((CheckBox)ctrl).Checked = false;
                            break;
                        }
                    }

                }
               //another

                foreach (var ctrl in Panel4.Controls)
                {
                    if (ctrl is DropDownList)
                    {
                        DropDownList ddl = ctrl as DropDownList;

                        if (ddl.ID == userSettingModel.UserControlId)
                        {
                            string str = userSettingModel.Status;
                            string[] str1 = str.Split(new char[] { '|' });

                            ddl.SelectedValue = str1[0];
                            ddl.SelectedItem.Text = str1[1];

                            break;
                        }
                    }
                }
                //another

                foreach (var ctrl in Panel6.Controls)
                {
                    if (ctrl is DropDownList)
                    {
                        DropDownList ddl = ctrl as DropDownList;

                        if (ddl.ID == userSettingModel.UserControlId)
                        {
                            string str = userSettingModel.Status;
                             string[] str1 = str.Split(new char[] { '|' });
                              string strValue = str1[0];
                              string strText = str1[1];
                            
                            if (strValue !="-3" && strText != "noValue")
                            {
                                //string[] str1 = str.Split(new char[] { '|' });
                                // ddl.SelectedValue = str1[0];
                                // ddl.SelectedItem.Text = str1[1];
                                ListItem listItem = new ListItem(strText, strValue);
                                ddl.Items.Add(listItem);
                                break;   
                            }
                            else
                            {
                                ddl.Items.Clear();
                                //ddl.SelectedValue = String.Empty;
                                //ddl.SelectedItem.Text = "";
                                break;
                            }                                                                                                                 
                            /////                            
                        }
                    }
                }


                
            }

        }


        private List<UserSettingModel> GetAllSettingBySelectedSettingId(int settingId)
        {
            List<UserSettingModel> userSettingModels = new List<UserSettingModel>();
            string query = String.Format("Select * from tblUserAtDealer where SettingNameId=@settingId");

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[1].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Clear();
                    command.Parameters.AddWithValue("@settingId", settingId);
                    connection.Open();
                    SqlDataReader rdr = command.ExecuteReader();
                    while (rdr.Read())
                    {
                        UserSettingModel userSettingModel = new UserSettingModel();
                        userSettingModel.ID = Convert.ToInt32(rdr[0]);
                        userSettingModel.UserControlId = rdr[1].ToString();
                        userSettingModel.Status = rdr[2].ToString();
                        userSettingModels.Add(userSettingModel);
                    }
                    connection.Close();
                }
            }
            return userSettingModels;
        }

        private void CleaeAllField()
        {
            foreach (var ctrl in Panel1.Controls)
            {              
                if (ctrl is CheckBox)
                {                    
                        ((CheckBox) ctrl).Checked = false;
                }

            }            
            foreach (var ctrl in Panel3.Controls)
            {               
                if (ctrl is CheckBox)
                {
                    ((CheckBox)ctrl).Checked = false;                   
                }
            }

            foreach (var ctrl in Panel6.Controls)
            {
                string selectedValueText = "";
                UserSettingModel userSettingModel = new UserSettingModel();
                if (ctrl is DropDownList)
                {
                      DropDownList ddl = ctrl as DropDownList;
                    ddl.Items.Clear();

                }

            }
           
        }


    }
}