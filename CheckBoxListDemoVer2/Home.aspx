<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="CheckBoxListDemoVer2.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table>
        <tr>
            <td>
                <b>Create Setting : </b>
            </td>
            <td>
                <asp:TextBox ID="settingTextBox" runat="server"></asp:TextBox>
            </td>
             <td>
                 <asp:Button ID="createButton" runat="server" Text="Create" OnClick="createButton_Click" />  
            </td>
            <td>
                <asp:DropDownList ID="settingNameDropDownList" Width="150px" runat="server" AutoPostBack="True" OnSelectedIndexChanged="settingNameDropDownList_SelectedIndexChanged"></asp:DropDownList>
            </td>
            <td>
                <asp:Button ID="upDateButton" runat="server" Text="Update" OnClick="upDateButton_Click" />
            </td>
             <td>
                 <asp:Button ID="deleteButton" runat="server" Text="Delete" OnClick="deleteButton_Click"/> 
            </td>            
        </tr>
           <tr>
               <td colspan="6">
                    <asp:Label ID="statusLabel" runat="server" Text=""></asp:Label>
               </td>
           </tr>
        </table>
    </div>
       <div style="float:right; padding-right:75px; font-weight:bold;">
                    <h3>Settings For User At Dealer Above For User At Dealer Above</h3>
                    <div style="text-align:left;">
                    <asp:Panel ID="Panel1" runat="server"> 
                    <asp:CheckBox ID="chkPiShowAll" runat="server" Text="Make Other User's Private Messages Visible" TextAlign="Right" style="font-weight:bold;" /><br />
                    <asp:CheckBox ID="chkPiMakePrivate" runat="server" Text="Make This User's New Messages Private" TextAlign="Right" style="font-weight:bold;" /><br />
                    <asp:CheckBox ID="chkPiAddFirstLeadOnly" runat="server" Text="Must Get Email/SMS Leads In Order" TextAlign="Right" style="font-weight:bold;" /><br />
                    <asp:CheckBox ID="chkPiMustContactLastEmail" runat="server" Text="Must Contact Last Email/SMS Lead" TextAlign="Right" style="font-weight:bold;" /><br />
                    <asp:CheckBox ID="chkPiBulkBlock" runat="server" Text="Block Bulk Message Blasts" TextAlign="Right" style="font-weight:bold;" /><br />
                    <asp:CheckBox ID="chkPiExportBlock" runat="server" Text="Block Customer List Exports" TextAlign="Right" style="font-weight:bold;" /><br />                                      
                    <asp:CheckBox ID="chkAllowAllSales" runat="server" Text="Search All Salespeople" TextAlign="Right" style="font-weight:bold;" /><br />
                    <asp:CheckBox ID="chkPiBlockSalesChange" runat="server" Text="Block Changing Salesperson" TextAlign="Right" style="font-weight:bold;" /><br />
                    <asp:CheckBox ID="chkPiInvalidBlock" runat="server" Text="Block Setting Invalid/Duplicate Status" TextAlign="Right" style="font-weight:bold;" /><br />
                    <asp:CheckBox ID="chkPiEnableChat" runat="server" Text="Enable Chat" TextAlign="Right" style="font-weight:bold;" /><br />
                    <asp:CheckBox ID="chkPiChatManager" runat="server" Text="Manage Chat Hub" TextAlign="Right" style="font-weight:bold;" /><br />
                    <asp:CheckBox ID="chkPiToDoManager" runat="server" Text="Manage To Do Lists" TextAlign="Right" style="font-weight:bold;" /><br />
                    <asp:CheckBox ID="chkPiTargetManager" runat="server" Text="Manage Target Leads" TextAlign="Right" style="font-weight:bold;" /><br />
                    </asp:Panel>  
                   <asp:Panel ID="Panel2" runat="server">
                    Home Type:<asp:dropdownlist Width="200px" ID="lstPiHomeType" runat="server" style="font-weight:bold;">
                                        <asp:ListItem Text="Sales" Value="Sales"></asp:ListItem>
                                        <asp:ListItem Text="Service" Value="Service"></asp:ListItem>  
                                        <asp:ListItem Text="Website" Value="Web"></asp:ListItem>                                  
                                  </asp:dropdownlist>
                    </asp:Panel>
                    <br />
                    <asp:Panel ID="Panel3" runat="server">
                    <asp:CheckBox ID="chkPiHomeSelectAllow" runat="server" Text="Allow Home Type Selection" TextAlign="Right" style="font-weight:bold;" /><br />
                    <asp:CheckBox ID="chkPiHomeVisitsAllow" runat="server" Text="Show Traffic Log On Sales Home Page" TextAlign="Right" style="font-weight:bold;" /><br />
                        <asp:CheckBox ID="chkPiTrafficDeleteAllow" runat="server" Text="Delete Visits On Sales Traffic Log" TextAlign="Right" style="font-weight:bold;" /><br />
                    </asp:Panel>
                   <asp:Panel ID="Panel4" runat="server">
                    Dept:<asp:DropDownList Width="200px" ID="ux_lstDepartments" runat="server" 
                         AutoPostBack="False">
                        </asp:DropDownList>
                   </asp:Panel>
                    </div>
           </div>
        <div>
            <asp:Panel ID="Panel5" runat="server">
              <b>Dealer:</b><asp:DropDownList ID="dealerDropDownList" Width="200px" runat="server" AutoPostBack="True" OnSelectedIndexChanged="dealerDropDownList_SelectedIndexChanged"></asp:DropDownList> 
            </asp:Panel>
        </div>
        <div>
            <asp:Panel ID="Panel6" runat="server">
              Blocked Status : <asp:DropDownList Width="200px" ID="blockStatusDropDownlist" runat="server">
                                       <%-- <asp:ListItem Text="Option1" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Option2" Value="2"></asp:ListItem>  
                                        <asp:ListItem Text="Option3" Value="3"></asp:ListItem> --%>

                             </asp:DropDownList>
            </asp:Panel>  
        </div>
    </form>
</body>
</html>
