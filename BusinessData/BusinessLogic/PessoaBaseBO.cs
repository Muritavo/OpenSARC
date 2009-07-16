using System;
using System.Collections.Generic;
using System.Text;
using BusinessData.Entities;
using System.Web.Security;
using System.Text.RegularExpressions;
using System.Net.Mail;
using System.Configuration;
using BusinessData.DataAccess;

namespace BusinessData.BusinessLogic
{
    public abstract class PessoaBaseBO
    {
        private Usuario usr;

        public abstract void InsertPessoa(PessoaBase professor, string perguntaSecreta, string respostaSecreta);

        public abstract void InsertPessoa(PessoaBase professor, string senha, string perguntaSecreta, string respostaSecreta);

        public abstract void DeletePessoa(PessoaBase pessoa);

        public abstract PessoaBase GetPessoaById(Guid Id);

        public void UpdateEmail(PessoaBase pessoa, string email)
        {
            Regex validaEmail = new Regex("\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*");
            if (!validaEmail.IsMatch(email))
            {
                throw new ArgumentException("Email inv�lido");
            }
            MembershipUser sec = Membership.GetUser(pessoa.Id);
            sec.Email = email;
            Membership.UpdateUser(sec);
        }

        public void ResetaSenha(PessoaBase pess)
        {
            MembershipUser pessoa = Membership.GetUser(pess.Id);
            string password = pessoa.ResetPassword();
            Membership.UpdateUser(pessoa);
            this.SendNewPassword(pessoa, password);
        }

        protected void SendNewPessoa(MembershipUser pessoa, string password)
        {
            string to = pessoa.Email;
            string from = ConfigurationManager.AppSettings["MailMessageFrom"];


            MailMessage message = new MailMessage(from, to);
            message.Subject = "Aloca��o de Recursos";
            message.Body = "Sistema de Aloca��o de Recursos Computacionais FACIN \n\n" +
                           "Voc� est� cadastrado(a) no Sistema de Aloca��o de Recursos da Faculdade de Inform�tica. \n" +
                           "Suas credenciais s�o: \n" +
                           "Login: " + pessoa.UserName + "\n" +
                           "Senha: " + password + "\n\n" +
                           "Acesse o site em: " + ConfigurationManager.AppSettings["AppURL"];

            SmtpClient client = new SmtpClient();
            client.Send(message);          
        }
        
        protected void SendNewPassword(MembershipUser pessoa, string password)
        {
            string to = pessoa.Email;
            string from = ConfigurationManager.AppSettings["MailMessageFrom"];

            MailMessage message = new MailMessage(from, to);
            message.Subject = "Sistema de Aloca��o de Recursos Computacionais FACIN - Altera��o de senha";
            message.Body = "Sistema de Aloca��o de Recursos Computacionais FACIN \n" +
                           ConfigurationManager.AppSettings["AppURL"] + "\n\n" +
                           "Sua senha foi resetada pelo administrador do sistema." +
                           " \n A nova senha �: " + password;

            SmtpClient client = new SmtpClient();
            client.Send(message); 
        }

        
    }
}
