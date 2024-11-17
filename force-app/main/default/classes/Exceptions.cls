public with sharing class Exceptions {
	public abstract class PortalException extends Exception {}
	public class NoAccessException extends PortalException {}
}