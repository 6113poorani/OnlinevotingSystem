package admin;

public class Excel {

		// TODO Auto-generated method stub
		String candidate_Name;
		String party_Name;
		String taluk_Name;
		int ward_No;
		int total_votes;
		
		public Excel(String candidate_Name, String party_Name, String taluk_Name, int ward_No, int total_votes) {
			super();
			this.candidate_Name = candidate_Name;
			this.party_Name = party_Name;
			this.taluk_Name = taluk_Name;
			this.ward_No = ward_No;
			this.total_votes = total_votes;
		}
		public String getCandidate_Name() {
			return candidate_Name;
		}
		public void setCandidate_Name(String candidate_Name) {
			this.candidate_Name = candidate_Name;
		}
		public String getParty_Name() {
			return party_Name;
		}
		public void setParty_Name(String party_Name) {
			this.party_Name = party_Name;
		}
		public String getTaluk_Name() {
			return taluk_Name;
		}
		public void setTaluk_Name(String taluk_Name) {
			this.taluk_Name = taluk_Name;
		}
		public int getWard_No() {
			return ward_No;
		}
		public void setWard_No(int ward_No) {
			this.ward_No = ward_No;
		}
		public int getTotal_votes() {
			return total_votes;
		}
		public void setTotal_votes(int total_votes) {
			this.total_votes = total_votes;
		}
		
		

	

}
