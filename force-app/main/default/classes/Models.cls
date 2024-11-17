public class Models {

	public class BusLine {
		@AuraEnabled public Bus bus {get; set;}
		@AuraEnabled public Line line {get; set;}
		@AuraEnabled public Id id {get; set;}
		@AuraEnabled public Date lastModifiedDate {get; set;}

		public BusLine(Bus bus, Line line) {
			this.bus = bus;
			this.line = line;
		}

		public BusLine(Bus_line__c busLine) {
			this.line = new Models.Line(busLine.Line__r.Name, busLine.Line__r.Id);
			this.id = busLine.Id;
			this.lastModifiedDate = busLine.LastModifiedDate.date();
		}
	}

	public class Line {
		@AuraEnabled public Id id {get; set;}
		@AuraEnabled public String name {get; set;}

		public Line(String lineName) {
			this.name = lineName;
		}

		public Line(Line__c line) {
			this.id = line.Id;
			this.name = line.Name;
		}

		public Line(String lineName, Id lineId) {
			this.id = lineId;
			this.name = lineName;
		}
	}

	public class Bus {
		@AuraEnabled public String name {get; set;}
		@AuraEnabled public String color {get; set;}
		@AuraEnabled public String mark {get; set;}
		@AuraEnabled public String model {get; set;}
		@AuraEnabled public List<Line> lines {get; set;}

		public Bus(Bus__c bus, List<Line> lines) {
			this.name = bus.Name;
			this.color = bus.Color__c;
			this.mark = bus.Mark__c;
			this.model = bus.Model__c;
			this.lines = lines;
		}
	}
}