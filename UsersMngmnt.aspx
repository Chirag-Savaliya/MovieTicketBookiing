<%@ Page Title="" Language="C#" MasterPageFile="~/MovieTickeBooking.master" AutoEventWireup="true" CodeFile="UsersMngmnt.aspx.cs" Inherits="Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <center>
  <div style="width:100%">
        <table border="0" width="50%" style="font-family:'Times New Roman';font-weight:bold">
            <tr>
                <td align="right">
                   <p>Select User Role</p>
                </td>
                <td>
                    <asp:RadioButton ID="rdbtnAdmn" runat="server" Text="Admin Users" GroupName="usrRole" AutoPostBack="true" OnCheckedChanged="rdbtnAdmn_CheckedChanged" />
                </td>
                <td>
                    <asp:RadioButton ID="rdbtnUsr" runat="server" Text="Client Users" GroupName="usrRole" AutoPostBack="true" OnCheckedChanged="rdbtnAdmn_CheckedChanged" />
                </td>
                <td>
                    <asp:RadioButton ID="rdbtnAll" runat="server" Text="All Users" GroupName="usrRole" Checked="true" AutoPostBack="true" OnCheckedChanged="rdbtnAdmn_CheckedChanged" />
                </td>
            </tr>
        </table>
        <table border="0" class="Tbl-Outer" style="font-family:'Times New Roman';font-weight:bold">
            <tr>
                <td align="center">
                  <asp:GridView ID="dtGrdUsrs" runat="server" AutoGenerateColumns="False" CellPadding="4" Visible="false" ForeColor="#333333" GridLines="None" Width="100%" OnRowDeleting="dtGrdUsrs_RowDeleting">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate> 
                                <asp:CheckBox ID="chbxHdr" runat="server" Width="2%" AutoPostBack="true" OnCheckedChanged="chbxHdr_CheckedChanged" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chbxClmn" runat="server" AutoPostBack="true" OnCheckedChanged="chbxClmn_CheckedChanged" />
                            </ItemTemplate>
                            <ControlStyle Width="3%" />
                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="3%" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="usrId" HeaderText="User Id" ReadOnly="True">
                        <ControlStyle Width="2%" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="2%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="usrFrstName" HeaderText="First Name">
                        <ControlStyle Width="5%" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="usrLstName" HeaderText="Last Name">
                        <ControlStyle Width="5%" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="usrAddrs" HeaderText="Address">
                        <ControlStyle Width="20%" />
                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="usrMono" HeaderText="Phone No">
                        <ControlStyle Width="5%" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="usrName" HeaderText="User Name">
                        <ControlStyle Width="10%" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="usrRole" HeaderText="User Role">
                        <ControlStyle Width="5%" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                        </asp:BoundField>
                        <asp:CommandField ButtonType="Button" HeaderText="Delete Users" ShowDeleteButton="True">
                        <ControlStyle Width="23%" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="23%" />
                        </asp:CommandField>
                    </Columns>
                    <EditRowStyle BackColor="#7C6F57" />
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#E3EAEB" />
                    <SelectedRowStyle BackColor="#CC3300" Font-Bold="True" ForeColor="#FFFF99" />
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
                  </asp:GridView>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Button ID="btnDltAll" runat="server" Text="DELETE SELECTED USERS" Visible="false" OnClick="btnDltAll_Click" CssClass="Btn" />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Button ID="btnRole" runat="server" Width="30%" Visible="false" CssClass="Btn" OnClick="btnRole_Click" />
                </td>
            </tr>
        </table>
  </div>
 </center>
</asp:Content>

